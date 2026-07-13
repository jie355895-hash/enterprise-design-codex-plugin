---
name: enterprise-design
description: Govern product-manager product design work for SaaS industrial systems from research through confirmed PRD, interactive Demo, in-Demo explanations, user acceptance, review, versioning, and conversation-driven maintenance.
---

# Enterprise Design Workflow

When the user communicates in Chinese, use Chinese for user-facing questions, confirmation drafts, PRDs, Demo explanations, review results, version summaries, and error messages.

## Product manager goal

The user needs to see, click, understand, and evaluate a product design. The user is not required to choose a frontend stack, component library, dependency, or code-maintenance strategy. Codex selects and maintains the implementation internally while keeping the product behavior and visual result aligned with confirmed product decisions.

UI规范主要参考Ant Design 5、Carbon Design System和WCAG 2.2。中央知识库只提供业务领域参考，不提供默认颜色、字体、布局、间距或组件规范。Use `ui-ux-pro-max` for design direction, visual quality, interaction design, and review.

Default new-Demo baseline: 1920 x 1080 canvas, 24-column grid, 8px spacing unit, 14px base font, 32px base control height, 6px base radius, and Ant Design 5 semantic color tokens. Existing project brand, UI system, and confirmed PRD override defaults.

Use `daisyUI` only for HTML plus Tailwind Demos. Use `shadcn/ui` only for explicit React plus Tailwind projects. Use `shadcn-vue` for Vue 3 plus Tailwind only when the project has no established component system. Existing project technology takes priority. Use one primary component system per Demo.

Review Demos against WCAG 2.2 AA: text contrast, visible and unobscured focus, keyboard operation, target size, form labels, error recovery, and non-color status expression.

## UI design rules

- Choose list, table, detail, form, workbench, board, timeline, tree, monitor, or big-screen patterns according to the user task.
- Use tables for structured comparison and filtering, lists for scanning, cards for light information blocks, and charts for explicit analytical questions.
- Table toolbars hold global search, filters, export, column settings, and global actions; batch actions appear after selection; row actions stay inline when few and move to overflow when many.
- Charts must expose title, definition, source, time range, unit, refresh time, threshold, legend, and drill-down when relevant. Critical meaning cannot rely on hover or color alone.
- Forms need visible labels, required markers, inline errors, save/submit feedback, recovery paths, draft protection for long forms, and unsaved-change protection.
- Use one icon family per Demo, no emoji as structural icons, and keep business icons separate from the circular explanation `i` icon.
- Keep fixed bars, modals, and Drawers from obscuring primary content or keyboard focus. Avoid nested scroll regions and layout jumps.
- For LIMS, separate sample, task, result, and report states. For MES/LIMS integration, show data owner, source, sync status, state owner, and failure compensation when relevant.
- For big screens, record target resolution, refresh time, alert priority, data source, and remote readability. For PDA, redesign for touch and one-task execution instead of shrinking desktop UI.

## Product manager workflow

Run the following sequence for product design work:

1. Receive the request and identify the request type and product form.
2. Research the current business, users, process, pain points, evidence, and constraints.
3. Identify relevant industrial domains and search the central knowledge base.
4. Make a preliminary scope judgment: goal, candidate scope, out-of-scope content, evidence, and assumptions.
5. Assess information completeness and ask every necessary clarification question; there is no fixed question count.
6. Analyze roles, tenants, organization and factory scope, data scope, permissions, workflow, states, exceptions, and notification type.
7. Design the product solution, information structure, interaction path, and visual direction.
8. Make the final scope decision and output the text confirmation draft; wait for user confirmation.
9. Generate the PRD design file from the confirmed text draft.
10. Run one PRD comprehensive validation covering both process and content.
11. Show the PRD summary, validation results, evidence, impact, suggestions, and necessary questions; wait for the user's answers or confirmation that no issue remains.
12. Revise and revalidate the PRD when an answer changes scope, roles, permissions, fields, states, or workflow; create a new PRD version instead of overwriting a confirmed version.
13. Mark the PRD as confirmed only after high-impact issues are cleared and the user confirms the validated PRD.
14. If a prototype exists, compare the confirmed PRD and prototype before Demo generation and resolve product-intent differences.
15. Run the Demo-before checklist and generate the interactive Demo from the confirmed PRD.
16. Generate Demo-page explanations and Demo notes from the confirmed PRD.
17. Run automatic checks and AI product-design review.
18. Let the user view, click, and experience the Demo, then capture acceptance and feedback.
19. Apply confirmed feedback through the appropriate requirement, PRD, prototype, or Demo change path and save new versions without overwriting confirmed outputs.

The text confirmation draft confirms the direction. The PRD is the detailed product design source for the Demo. The Demo is the reviewable interactive expression of the PRD.

### Task branches

- New requirement: run the full research, confirmation, PRD, Demo, review, and acceptance flow.
- Existing confirmed PRD with no Demo: verify the current PRD and continue to Demo after confirmation.
- Visual or interaction revision with no product-intent change: compare the current source and output, confirm the impact plan, and create a new Demo version without recreating the PRD.
- Prototype-to-Demo synchronization: use the prototype comparison gate and return to PRD confirmation when product intent changes.
- Review or audit only: inspect existing evidence and report findings; do not generate a new PRD or Demo unless the user requests a confirmed product change.
- Plugin, knowledge, template, tool, or workspace maintenance: use the seven-scope maintenance flow, not the product-Demo flow.

Use these confirmation states consistently: `草稿`, `待确认`, `部分确认`, `需修改`, `已确认`, `已暂停`, `已拒绝`, `当前`, and `已归档`. Ambiguous replies do not confirm unresolved high-impact items.

## Research and evidence

Requirement identification answers what the user asked for. Research also answers why it is needed, who uses it, how the current process works, what is wrong, what evidence exists, and what is in scope.

Read relevant business documents, screenshots, prototypes, existing pages, menus, process rules, roles, permissions, project files, and central knowledge. Record user goals, current flow, pain points, constraints, known facts, assumptions, pending items, in-scope content, and out-of-scope content.

Search the central knowledge base through `<WORKSPACE_ROOT>\知识库\INDEX.md`. Read only relevant domains. Carry knowledge version, sources, adopted references, rejected references, assumptions, and pending items into the project control record, text confirmation, PRD, Demo notes, AI review, and confirmed version record.

Reference knowledge is for informed design and does not override current requirements, confirmed decisions, or mandatory plugin rules.

## Clarification gate

Do not generate a final Demo directly from a vague request. First provide request type, information completeness, missing information, necessary questions, and optional default assumptions.

Ask only questions whose answers may change page structure, roles, data, permissions, states, workflow, notifications, product form, or visual direction. Do not ask filler questions. Existing evidence may satisfy the information gap.

Even when no further question is needed, output the text confirmation draft and wait for confirmation.

## Text confirmation draft

The text confirmation draft must cover, when relevant:

- request type and product form
- information completeness
- page or module goal
- users and roles
- role differences and evidence
- core data objects and key fields
- page entrance and structure
- frequent operations and permissions
- states and workflow
- normal and actionable notifications
- explanation Drawer coverage
- visual direction
- adopted knowledge and sources
- default assumptions
- pending items
- out-of-scope content
- unsimulated integrations and uncovered exception flows

Only after the user confirms the draft may Codex generate the PRD.

## PRD design file

Create the PRD in `业务内容文档` as a product-facing design file, normally named `PRD_<module>_v1.0.md`. Do not require the user to write it manually.

The PRD must include product background, goals, preliminary and final scope, out-of-scope content, users, roles, entrances, tenant and data scope, data objects, fields, field sources and statistical definitions, page structure, operations, permission boundaries, states, workflows, exceptions, notification handling, explanation content, visual direction, interaction requirements, Demo acceptance criteria, evidence, assumptions, pending items, and unresolved questions.

After generating the PRD, run a single comprehensive validation with two parts:

- Process validation: entrances, role and tenant boundaries, data scope, permission conditions, button preconditions and results, state transitions, normal and exception paths, loading/empty/error/no-permission states, notification handling loops, write-back, audit, cross-module dependencies, and failure recovery.
- Content validation: goal, scope, roles, fields, data sources, statistical definitions, page structure, operations, Drawer coverage, Demo interactions, acceptance criteria, evidence conflicts, assumptions, and pending items.

Show passed items, process issues, content issues, impact, evidence, suggestions, and only the questions needed to resolve the current uncertainty. There is no fixed question count. Even when no question is needed, wait for the user to confirm that the validated PRD has no issue. High-impact unresolved issues block Demo generation. Low-impact items may proceed as explicit assumptions recorded in the PRD, Demo notes, and version record. Bind the validation record to the PRD version. If the user answers in a way that changes product scope, roles, permissions, fields, states, or workflow, create a new PRD version and revalidate. Do not generate the Demo before the validated PRD is confirmed.

## Role-driven industrial design

This workspace supports SaaS industrial systems, workbenches, dashboards, big screens, LIMS, MES, QMS, IIoT, equipment, testing, quality, warehouse, digital twins, and mixed systems.

For relevant roles, judge page entrance, visible modules and fields, default view, frequent operations, operation permissions, state operation scope, workflow responsibility, data scope, explanation emphasis, and tenant, company, organization, factory, laboratory, and department scope.

When MES and LIMS or other domains are mixed, state the module, product form, system of record, data owner, shared objects, identifiers, synchronization boundary, status owner, workflow owner, conflict handling, audit trail, failure recovery, and whether each conclusion is confirmed or assumed.

Do not invent role permissions. If the source is missing, mark the item as `待确认` or `默认假设`. A multi-role difference matrix must include role, entrance, data scope, visible content, available operations, default view, workflow responsibility, and evidence.

## Notification rules

Classify notifications as normal reminders or actionable reminders.

Normal reminders support awareness, viewing details, and marking as read.

Actionable reminders must include object, trigger rule, severity, responsible role, trigger or deadline time, go-to-handle entry, handling page or workflow, state transition, and result write-back.

Device alarms, near-due or overdue tasks, pending approvals, abnormal results, maintenance expiry, calibration expiry, and failed data uploads are actionable reminders.

## Explanation and Demo notes

Generate Demo-page explanations from the confirmed PRD. Explanations may cover page, module, region, field, status, workflow node, data metric, role boundary, and notification handling.

Use a right-side Drawer and a unified circular `i` or `ⓘ` entry. Keep explanation entries separate from business buttons, filters, status tags, pagination, search, and view controls. Business buttons such as 查看, 编辑, 流程, 下载, and 更多 keep their original functions.

Repeated visual components may share one component-level explanation only when business meaning, function, data meaning, interaction, role, state, permission, workflow, and risk are materially the same. The same component needs separate explanations when its context differs.

Demo notes must carry PRD path and version, Demo-to-PRD source relationship, role differences and evidence, data scope, page entrance, permission assumptions, workflow assumptions, notification handling, adopted knowledge, rejected knowledge, default assumptions, pending items, and unsimulated integrations.

The explanation coverage matrix must also judge the current tenant, company, organization, factory, laboratory, department, and data scope; the current role and permissions; visible content; field meaning and source; button purpose, preconditions, results, and disabled reason; state and workflow context; and risk or audit impact. Explain only content the current role is allowed to see or operate. Explanation content must never bypass tenant or permission isolation.

If the Demo needs an explanation not supported by the PRD, mark it pending or update the PRD first. Do not invent business rules in the Demo.

## Demo review and acceptance

After production, check page loading, core interactions, roles, permissions, data scope, states, workflows, notifications, explanation Drawer behavior, industrial fit, responsive layout, loading/empty/error/no-permission states, and visual quality.

AI review does not replace user acceptance. The user must be able to view and click the Demo. User feedback is handled as a product change, not as an untracked code patch.

## Prototype and Demo synchronization

When a prototype changes, read the current PRD, prototype, and Demo. Compare structure, fields, content, interactions, states, permissions, roles, and visuals. Output differences and impact. If the change affects product intent, update the PRD after confirmation before changing the Demo. Then create a new Demo version, run the after-checklist, and record prototype source and version.

## Output versioning

All confirmed outputs are versioned: `业务内容文档`, `Demo`, `原型`, and `技术依赖`.

Never overwrite a confirmed output in place. Preserve old versions, create a new version for every confirmed change, and record source, reason, change summary, reviewer, confirmation state, and pending items. A rollback creates a new version and never deletes history.

Technical implementation details, component choice, dependencies, backups, and control-file records are maintained internally by Codex. Ask the user only when a technical decision materially changes the product result or existing project behavior.

Use `业务内容文档/versions/vX.Y`, `Demo/versions/vX.Y`, `原型/versions/vX.Y`, and `技术依赖/versions/vX.Y` for confirmed output versions. Each version folder contains the output and `version.json`; `CODEX_PLUGIN_DO_NOT_EDIT/output-version-manifest.json` indexes the current version for each output type. A rollback creates a new version and never deletes history.

## Conversation-driven maintenance

The user-facing tool only creates new projects. There is no user-facing sync button. The user updates knowledge, rules, templates, tools, workspace context, and projects by describing the change in the Codex conversation.

Codex proposes the target change, waits for confirmation, assesses downstream impact, proposes linked changes, waits for linked confirmation, preserves versions, backs up projects, synchronizes only confirmed control files, and verifies alignment.

The seven independently updateable scopes are: central knowledge base, plugin rules, project template, project creation tool, sync tool, workspace context, and child-project control files.

Product design work and system maintenance work are separate routes. Maintenance does not generate a PRD or Demo. For a maintenance request, identify the target scope and evidence, propose the exact change and version impact, wait for confirmation, update the target, perform a seven-scope impact assessment, show linked changes, wait for linked confirmation, back up projects, synchronize only confirmed control files, preserve all previous versions, and verify final alignment. Changes to workflow gates, UI rules, Drawer rules, versioning, output structure, or project initialization must be synchronized across every affected scope. Public GitHub release is a separate desensitization and release-confirmation step.

## Project initialization

The user-facing project creation tool resolves the highest semantic-versioned plugin and creates a complete project with `业务内容文档`, `Demo`, `原型`, `技术依赖`, `CODEX_PLUGIN_DO_NOT_EDIT`, hidden `AGENTS.md`, `PROJECT_CONTEXT.md`, `PLUGIN_VERSION.json`, and required control templates.

