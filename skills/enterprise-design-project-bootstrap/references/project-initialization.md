# Project Initialization Reference

## Protected workspace folders

Do not initialize these as projects:

- `00-企业设计插件`
- `00-企业设计工具`
- `00-企业设计模板`
- `知识库`
- `工作区备份`
- `项目备份`
- `参考资料`
- `外部参考资料`
- `外部知识库`

## Root decision

Use the selected empty folder as the standalone project root when it has no initialized project ancestor and is not a protected output or workspace folder. This includes a direct child of `<WORKSPACE_ROOT>` and an empty folder inside an ordinary non-project container. Do not move the folder into another container; existing absolute paths and workspace automation depend on the current location.

## Child decision

When the selected folder is empty and its nearest ancestor has `CODEX_PLUGIN_DO_NOT_EDIT\PLUGIN_VERSION.json`, use the selected folder itself as the child project root and record that ancestor as `ParentProject`. The user does not need to say “子项目”. An explicit `Child` mode remains supported for a non-empty folder when the user has clearly identified it as a child project.

When the selected folder is inside `Demo`, `原型`, `业务内容文档`, `技术依赖`, or `CODEX_PLUGIN_DO_NOT_EDIT`, use the nearest initialized ancestor as the project root and never initialize the selected folder. For a non-empty nested folder outside those output folders, use the nearest initialized ancestor by default and ask only when the user is asking to initialize that nested folder as a project.

## Existing project handling

An initialized project is recognized by `CODEX_PLUGIN_DO_NOT_EDIT\PLUGIN_VERSION.json`, `CODEX_PLUGIN_DO_NOT_EDIT\PROJECT_CONTEXT.md`, or a workspace `AGENTS.md` together with at least three output folders. Existing files are preserved. The initializer adds missing controls and updates only controlled plugin metadata.

## Initialization result

The initializer should report project root, project type, parent project, active plugin version, created files, preserved files, and any pending ambiguity. It should never claim that product work is complete merely because project initialization succeeded.

