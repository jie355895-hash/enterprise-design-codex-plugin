---
name: enterprise-design-project-bootstrap
description: Automatically initialize a selected blank project or subproject folder in the active workspace when the Enterprise Design Codex Plugin is selected. It creates missing project controls, inherits the latest plugin rules, protects business outputs, and routes product-design work through the enterprise workflow.
---

# Enterprise Design Project Bootstrap

Use this skill when the user selects the Enterprise Design Codex Plugin and provides a project folder in the active workspace. The selected folder is the work target; the user does not need to repeat the skill instruction or run a command.

## Core behavior

1. Resolve the referenced file or folder and keep all writes inside the configured workspace root.
2. Resolve the active plugin package from the current Codex installation; if a workspace contains versioned plugin packages, use the highest semantic version.
3. Identify the project root before creating anything:
   - If the selected folder already has `CODEX_PLUGIN_DO_NOT_EDIT\PLUGIN_VERSION.json`, it is the current project root.
   - If the selected folder is empty and has no initialized project ancestor, it becomes a standalone project root, whether it is directly under `<WORKSPACE_ROOT>` or inside an ordinary non-project folder.
   - If the selected folder is empty and its nearest initialized ancestor is a project root, it becomes a child project automatically. The user does not need to say “子项目”.
   - If the selected folder is inside `Demo`, `原型`, `业务内容文档`, `技术依赖`, or `CODEX_PLUGIN_DO_NOT_EDIT`, it remains part of the nearest project and is never initialized as a child project.
   - A non-empty nested folder without project markers remains part of the nearest project when one exists; without an ancestor project marker, stop for clarification instead of guessing.
   - Never initialize `versions`, backup folders, plugin folders, tool folders, template folders, or the central knowledge base as projects.
4. Run `scripts/ensure-project-context.ps1` internally in `Auto` mode. The user must not be asked to run it.
5. Create only missing project control files and folders. Update only controlled metadata such as `PLUGIN_VERSION.json` and `PROJECT_CONTEXT.md` when needed.
6. Preserve existing business documents, Demos, prototypes, technical dependencies, role matrices, assumptions, reviews, version records, and existing `AGENTS.md` content.
7. After initialization, continue with the Enterprise Design Codex Plugin workflow. Initialization never generates a PRD, Demo, prototype, or business content by itself.

## Files created when missing

Create these inside the identified project root:

- `AGENTS.md` as a hidden pointer to the workspace rules
- `业务内容文档`
- `Demo`
- `原型`
- `技术依赖`
- `CODEX_PLUGIN_DO_NOT_EDIT\PROGRAM_FILES`
- `CODEX_PLUGIN_DO_NOT_EDIT\PROJECT_CONTEXT.md`
- `CODEX_PLUGIN_DO_NOT_EDIT\PLUGIN_VERSION.json`
- `CODEX_PLUGIN_DO_NOT_EDIT\output-version-manifest.json`
- missing checklists, confirmation, assumption, review, version, and knowledge-reference templates from the latest plugin

For a child project, record `ProjectType: child` and `ParentProject` in its context. The child has its own control folder and version marker but inherits the workspace and parent rules.

## Safety rules

- Stop on a path outside the configured workspace root, a non-empty nested folder without enough project evidence, a case-insensitive collision, a locked destination, or an existing destination that would require overwriting.
- Never move, rename, delete, or overwrite business outputs during initialization.
- An empty selected folder is sufficient evidence for initialization only when it is outside protected output folders; its root/child type is determined by the nearest project marker.
- Never copy the central knowledge base into a project. Record references only when a product-design task uses it.
- Treat project-specific control records as user/project data; add them only when missing.
- If a non-empty nested folder could be either a normal content folder or a child project, ask one concise question before creating controls there.

## UI activation flow

When this plugin is selected in the Codex plugin picker, the selected folder is treated as the project context. The skill initializes that folder before product-design work:

`选择 Enterprise Design Codex Plugin → 选择空白项目文件夹 → 自动判断根项目/子项目 → 创建控制文件 → 进入产品设计流程`

Selecting a blank output subfolder does not create a new project. Selecting an empty ordinary folder under an existing project creates a child project automatically.

## After initialization

Read the nearest project `AGENTS.md`, the workspace instructions, the active plugin, and the project context. Then follow the latest workflow, including the clarification gate, text confirmation, PRD confirmation, Demo review, role/permission analysis, knowledge-base reference recording, and version control.

For the project-root decision details and protected-folder list, read [references/project-initialization.md](references/project-initialization.md). For deterministic initialization, use [scripts/ensure-project-context.ps1](scripts/ensure-project-context.ps1).

