param(
  [Parameter(Mandatory=$true)]
  [string]$TargetPath,
  [ValidateSet('Auto','Standalone','Child')]
  [string]$Mode = 'Auto',
  [string]$WorkspaceRoot,
  [string]$PluginRoot
)

$ErrorActionPreference = 'Stop'
$workspace = $null
$protectedNames = @(
  '00-企业设计插件','00-企业设计工具','00-企业设计模板','知识库',
  '工作区备份','项目备份','参考资料','外部参考资料','外部知识库'
)
$projectOutputNames = @('业务内容文档','Demo','原型','技术依赖','CODEX_PLUGIN_DO_NOT_EDIT')

function Get-DirectoryPath($path) {
  if (-not (Test-Path -LiteralPath $path)) { throw "目标路径不存在：$path" }
  $item = Get-Item -LiteralPath $path -Force
  if (-not $item.PSIsContainer) { $item = $item.Directory }
  (Resolve-Path -LiteralPath $item.FullName).Path
}

function Test-InWorkspace($path) {
  $root = (Resolve-Path -LiteralPath $workspace).Path.TrimEnd('\')
  $candidate = (Resolve-Path -LiteralPath $path).Path.TrimEnd('\')
  return ($candidate -eq $root -or $candidate.StartsWith($root + '\', [System.StringComparison]::OrdinalIgnoreCase))
}

function Find-InitializedAncestor($directory) {
  $current = Get-Item -LiteralPath $directory -Force
  while ($null -ne $current) {
    if (Test-Path -LiteralPath (Join-Path $current.FullName 'CODEX_PLUGIN_DO_NOT_EDIT\PLUGIN_VERSION.json')) {
      return $current.FullName
    }
    $parent = $current.Parent
    if ($null -eq $parent -or $current.FullName.TrimEnd('\') -eq $workspace.TrimEnd('\')) { break }
    $current = $parent
  }
  return $null
}

function Test-EmptyFolder($directory) {
  $items = @(Get-ChildItem -LiteralPath $directory -Force | Where-Object { $_.Name -notin @('desktop.ini','.DS_Store') })
  return $items.Count -eq 0
}

function Test-IsInsideProjectOutput($directory, $projectRoot) {
  $root = $projectRoot.TrimEnd('\')
  $candidate = $directory.TrimEnd('\')
  if ($candidate -eq $root) { return $false }
  $relative = $candidate.Substring($root.Length).TrimStart('\')
  $firstSegment = $relative.Split('\')[0]
  return $projectOutputNames -contains $firstSegment
}

function Add-IfMissing($source, $destination, $created, $preserved) {
  if (-not (Test-Path -LiteralPath $source)) { return }
  if (Test-Path -LiteralPath $destination) {
    $preserved.Add($destination)
    return
  }
  New-Item -ItemType Directory -Path (Split-Path $destination -Parent) -Force | Out-Null
  Copy-Item -LiteralPath $source -Destination $destination -Recurse -Force
  $created.Add($destination)
}

$target = Get-DirectoryPath $TargetPath
$workspaceCandidate = if ($WorkspaceRoot) { $WorkspaceRoot } elseif ($env:ENTERPRISE_DESIGN_WORKSPACE_ROOT) { $env:ENTERPRISE_DESIGN_WORKSPACE_ROOT } else { (Get-Item -LiteralPath $target -Force).Parent.FullName }
if (-not (Test-Path -LiteralPath $workspaceCandidate -PathType Container)) { throw "工作区根目录不存在：$workspaceCandidate" }
$workspace = (Resolve-Path -LiteralPath $workspaceCandidate).Path.TrimEnd('\')
$pluginRoot = if ($PluginRoot) { (Resolve-Path -LiteralPath $PluginRoot).Path } else { Split-Path -Parent (Split-Path -Parent (Split-Path -Parent $PSScriptRoot)) }
if (-not (Test-InWorkspace $target) -or $target.TrimEnd('\') -eq $workspace.TrimEnd('\')) {
  throw '目标必须位于工作区根目录内部，且不能是工作区根目录。'
}
$targetName = (Get-Item -LiteralPath $target -Force).Name
if ($protectedNames -contains $targetName -and (Get-Item -LiteralPath $target -Force).Parent.FullName.TrimEnd('\') -eq $workspace.TrimEnd('\')) {
  throw "受保护的工作区目录不能初始化为项目：$target"
}

$ancestor = Find-InitializedAncestor $target
$targetIsEmpty = Test-EmptyFolder $target
$targetIsInsideProjectOutput = $false
if ($ancestor) {
  $targetIsInsideProjectOutput = Test-IsInsideProjectOutput $target $ancestor
}
$projectRoot = $null
$projectType = 'standalone'
$parentProject = ''

if ($Mode -eq 'Child') {
  if (-not $ancestor -or $ancestor.TrimEnd('\') -eq $target.TrimEnd('\')) {
    throw '子项目必须位于已初始化的父项目内部。'
  }
  if ($targetIsInsideProjectOutput) {
    throw 'Demo、原型、业务内容文档、技术依赖和项目控制目录不能初始化为子项目。'
  }
  $projectRoot = $target
  $projectType = 'child'
  $parentProject = $ancestor
} elseif ($Mode -eq 'Standalone') {
  $projectRoot = $target
  $projectType = 'standalone'
} elseif ($ancestor) {
  if ($ancestor.TrimEnd('\') -eq $target.TrimEnd('\')) {
    $projectRoot = $ancestor
    $projectType = 'existing'
  } elseif ($targetIsEmpty -and -not $targetIsInsideProjectOutput) {
    $projectRoot = $target
    $projectType = 'child'
    $parentProject = $ancestor
  } else {
    $projectRoot = $ancestor
    $projectType = 'existing'
  }
} else {
  $parent = (Get-Item -LiteralPath $target -Force).Parent.FullName.TrimEnd('\')
  if (-not $targetIsEmpty -and $parent -ne $workspace.TrimEnd('\')) {
    throw '嵌套目录尚未明确为子项目；请由Codex确认后再初始化。'
  }
  $projectRoot = $target
  $projectType = 'standalone'
}

$versionedPlugins = @(Get-ChildItem -LiteralPath $pluginRoot -Directory -ErrorAction SilentlyContinue |
  Where-Object { $_.Name -match '_V\d+\.\d+\.\d+$' } |
  Sort-Object { [version]($_.Name -replace '^.*_V','') } -Descending |
  Select-Object -First 1)
$plugin = if ($versionedPlugins.Count -gt 0) { $versionedPlugins[0] } elseif (Test-Path -LiteralPath (Join-Path $pluginRoot '.codex-plugin\plugin.json')) { Get-Item -LiteralPath $pluginRoot -Force } else { $null }
if (-not $plugin) { throw "未找到可用插件包：$pluginRoot" }
$manifestPath = Join-Path $plugin.FullName '.codex-plugin\plugin.json'
$manifest = if (Test-Path -LiteralPath $manifestPath) { Get-Content -LiteralPath $manifestPath -Raw -Encoding UTF8 | ConvertFrom-Json } else { $null }
$resolvedVersion = if ($plugin.Name -match '_V\d+\.\d+\.\d+$') { 'V' + ($plugin.Name -replace '^.*_V','') } elseif ($manifest.version) { 'V' + $manifest.version } else { 'unknown' }
$templateRoot = Join-Path $plugin.FullName 'templates\project\CODEX_PLUGIN_DO_NOT_EDIT'
if (-not (Test-Path -LiteralPath $templateRoot -PathType Container)) { throw "缺少项目控制模板：$templateRoot" }

$created = New-Object System.Collections.Generic.List[string]
$preserved = New-Object System.Collections.Generic.List[string]
$updated = New-Object System.Collections.Generic.List[string]

$agentsPath = Join-Path $projectRoot 'AGENTS.md'
if (-not (Test-Path -LiteralPath $agentsPath)) {
  Set-Content -LiteralPath $agentsPath -Value @"
# Project Instructions

This project is under `<WORKSPACE_ROOT>` and follows `<WORKSPACE_ROOT>\AGENTS.md`.

Active plugin: Enterprise Design Codex Plugin resolved from the current Codex installation.
Project initialization and maintenance are handled by the Enterprise Design Project Bootstrap skill and the Codex conversation.
"@ -Encoding UTF8
  $created.Add($agentsPath)
} else { $preserved.Add($agentsPath) }
attrib +h $agentsPath

foreach ($folder in @('业务内容文档','Demo','原型','技术依赖','CODEX_PLUGIN_DO_NOT_EDIT','CODEX_PLUGIN_DO_NOT_EDIT\PROGRAM_FILES')) {
  $folderPath = Join-Path $projectRoot $folder
  if (-not (Test-Path -LiteralPath $folderPath -PathType Container)) {
    New-Item -ItemType Directory -Path $folderPath -Force | Out-Null
    $created.Add($folderPath)
  }
}

$controlFolder = Join-Path $projectRoot 'CODEX_PLUGIN_DO_NOT_EDIT'
$controlFiles = @('DELIVERY_STRUCTURE.md','demo-before-checklist.md','demo-after-checklist.md','role-permission-matrix.md','visual-acceptance.md','design-confirmation.md','assumptions.md','demo-review.md','output-versioning.md','output-version-manifest.json','knowledge-reference.md')
foreach ($file in $controlFiles) {
  Add-IfMissing (Join-Path $templateRoot $file) (Join-Path $controlFolder $file) $created $preserved
}
$programTemplate = Join-Path $templateRoot 'PROGRAM_FILES'
if (Test-Path -LiteralPath $programTemplate -PathType Container) {
  foreach ($file in (Get-ChildItem -LiteralPath $programTemplate -File -Force)) {
    Add-IfMissing $file.FullName (Join-Path $controlFolder ('PROGRAM_FILES\' + $file.Name)) $created $preserved
  }
}

$markerPath = Join-Path $controlFolder 'PLUGIN_VERSION.json'
$marker = if (Test-Path -LiteralPath $markerPath) { Get-Content $markerPath -Raw -Encoding UTF8 | ConvertFrom-Json } else { [pscustomobject]@{} }
$marker | Add-Member -NotePropertyName plugin -NotePropertyValue 'Enterprise Design Codex Plugin' -Force
$marker | Add-Member -NotePropertyName version -NotePropertyValue $resolvedVersion -Force
$marker | Add-Member -NotePropertyName status -NotePropertyValue 'active' -Force
$marker | Add-Member -NotePropertyName managedBy -NotePropertyValue 'CODEX_PLUGIN_DO_NOT_EDIT' -Force
$marker | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath $markerPath -Encoding UTF8
$updated.Add($markerPath)

$contextPath = Join-Path $controlFolder 'PROJECT_CONTEXT.md'
$parentLine = if ($parentProject) { $parentProject } else { '无' }
$context = @"
# Project Context

Project: $((Get-Item -LiteralPath $projectRoot -Force).Name)
ProjectRoot: $projectRoot
ProjectType: $projectType
ParentProject: $parentLine
Workspace: $workspace
Resolved Plugin: $($plugin.FullName)
Central Knowledge Base: $workspace\知识库
Resolved version: $resolvedVersion
Initialized At: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')

Initialization creates project controls only. Business outputs require the Enterprise Design Codex Plugin workflow and user confirmation gates.
"@
if (-not (Test-Path -LiteralPath $contextPath)) {
  Set-Content -LiteralPath $contextPath -Value $context -Encoding UTF8
  $created.Add($contextPath)
} else {
  $preserved.Add($contextPath)
}

[pscustomobject]@{
  status = 'initialized'
  projectRoot = $projectRoot
  projectType = $projectType
  parentProject = $parentProject
  plugin = $plugin.Name
  created = @($created | ForEach-Object { $_ })
  preserved = @($preserved | ForEach-Object { $_ })
  updated = @($updated | ForEach-Object { $_ })
  businessOutputsChanged = $false
} | ConvertTo-Json -Depth 8

