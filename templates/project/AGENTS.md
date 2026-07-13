# Project Instructions

This project is initialized under the selected workspace root. Product design work follows the nearest workspace instructions and the active Enterprise Design Codex Plugin.

Active plugin:

活动插件：当前 Codex 会话解析到的 Enterprise Design Codex Plugin 最新版本。

Do not ignore the workspace product design workflow or explanation rules.

## Conversation-Driven Updates

Knowledge-base, plugin-rule, tool, template, and project-control updates are requested through the Codex conversation. The user must not be asked to manually edit project control files or run maintenance commands.

For each update, Codex must first propose the target change and wait for confirmation. After the target changes, Codex must assess all seven update scopes, show concrete linked changes, and wait for confirmation before propagating them. Only confirmed project-control files may be synchronized; project output folders remain protected.

## Required Workflow

1. 需求接收与需求类型识别
2. 需求调研与证据收集
3. 相关领域识别与中央知识库检索
4. 需求定义与范围确认
5. 需求澄清
6. 业务分析
7. 方案设计
8. 文字版确认稿
9. 用户确认文字版确认稿
10. 生成PRD设计文件
11. 用户确认PRD设计文件
12. 根据PRD生成Demo
13. 根据PRD生成Demo内说明
14. Demo自动检查、AI评审和用户体验验收
15. 迭代与版本保存

## Mandatory Clarification Gate

If the user only says something like "做一个XX页面Demo" and does not provide enough business context, do not directly generate the final Demo.

First ask the minimum necessary clarification questions, unless existing project files already provide enough context.

Clarification questions have no fixed count. Ask only what is necessary for the current information gap. Do not ask filler questions just to satisfy a number.

## Text Confirmation Before Demo

Do not generate the Demo immediately even when there are no clarification questions.

Before Demo generation, output a text confirmation draft and wait for user confirmation.

The text confirmation draft should include:

- 需求类型
- 信息完整度
- 页面/模块目标
- 使用角色
- 核心数据对象
- 页面结构
- 关键字段
- 高频操作
- 状态与流程
- 说明 Drawer 覆盖对象
- 默认假设或依据来源

Only after the user confirms the text draft is correct may the PRD design file be generated. Only after the user confirms the PRD may Demo generation begin.

## Task Branches and Confirmation States

- New requirement: run the full research, confirmation, PRD, Demo, review, and acceptance flow.
- Existing confirmed PRD with no Demo: verify the current PRD and continue to Demo after confirmation.
- Visual or interaction revision with no product-intent change: compare the current source and output, confirm the impact plan, and create a new Demo version without recreating the PRD.
- Prototype-to-Demo synchronization: compare the prototype and Demo first; return to PRD confirmation when product intent changes.
- Review or audit only: inspect existing evidence and report findings; do not generate a new PRD or Demo unless a product change is requested.

Use these confirmation states consistently: `草稿`, `待确认`, `部分确认`, `需修改`, `已确认`, `已暂停`, `已拒绝`, `当前`, and `已归档`. Ambiguous replies do not confirm unresolved high-impact items.

## Research and PRD

需求识别回答用户提出了什么；需求调研还要分析为什么做、为谁做、当前流程、现有问题、依据、范围和约束。调研优先读取业务文档、截图、原型、现有页面、菜单、流程规则、角色岗位、权限配置、项目文件和中央知识库。

文字版确认稿确认后必须生成PRD设计文件。PRD至少包含目标、范围、角色、入口、数据、字段、页面结构、操作、权限、状态、流程、异常、通知、说明内容、视觉方向、Demo交互要求、Demo验收标准、依据、假设和待确认项。

PRD生成后必须等待用户确认。PRD是Demo页面、交互、状态、权限和页面内说明的产品依据，未确认PRD不得生成Demo。

## UI Design Standard

新Demo默认参考Ant Design 5、Carbon Design System和WCAG 2.2，中央知识库只作为业务参考。默认画布为1920×1080，使用24栅格、8px基础单位、14px基础字号、32px基础控件高度和6px基础圆角；项目已有UI规范和确认PRD优先。

HTML + Tailwind使用daisyUI，React + Tailwind使用shadcn/ui，Vue 3 + Tailwind在没有既有组件体系时使用shadcn-vue；已有项目技术和组件系统优先。

Confirmed output versions use `业务内容文档\versions\vX.Y`、`Demo\versions\vX.Y`、`原型\versions\vX.Y` and `技术依赖\versions\vX.Y`; each version folder contains `version.json`, and `CODEX_PLUGIN_DO_NOT_EDIT\output-version-manifest.json` records current versions. Never overwrite a confirmed output or delete version history.

## Role-Driven Design

User roles must affect design decisions, not only appear as descriptive text.

This workspace is for SaaS industrial systems. In the same company, same module, and same page, different roles may see completely different data, operations, page content, and page entrances.

SaaS industrial systems may include enterprise admin pages, workbenches, dashboards/big screens, LIMS, MES, IoT monitoring, digital twins, quality/inspection, test management, and equipment/asset management. Do not default every request to a list-detail admin page. Before design, identify the product form and state it in the text confirmation draft.

For each relevant role, judge:

- visible modules
- visible fields
- default view
- frequent operations
- operation permissions
- state operation scope
- workflow responsibilities
- data scope
- explanation Drawer emphasis
- page entrance
- visible content blocks
- tenant/company/organization/factory data scope

For multi-role pages, provide a role difference matrix before Demo confirmation. Cover role, page entrance, data scope, visible content, available operations, default view, and workflow responsibility.

If role information is missing and it affects page structure, fields, buttons, permissions, status, or workflow, ask for clarification before Demo confirmation.

Do not invent role permissions. Role differences must come from user input, PRD, screenshots, prototypes, menus, permission configuration, role/job descriptions, workflow rules, data-permission rules, or previously confirmed text drafts. If there is no source, mark the item as "待确认" or "默认假设". The role difference matrix must include a source/evidence column.

Demo notes must be generated from the confirmed PRD and include PRD path/version, Demo-to-PRD source relationship, the role difference matrix, source/evidence, default assumptions, pending confirmations, data-scope assumptions, page-entrance assumptions, operation-permission assumptions, workflow-permission assumptions, and Demo-page explanation coverage. Version records must also include these items.

## Notification Rules

Notifications must be classified as either normal reminders or actionable reminders.

Normal reminders are for awareness only: read, view details, mark as read.

Actionable reminders require a handling loop: object, trigger rule, severity, responsible role, trigger/deadline time, go-to-handle entry, handling page or workflow, status transition, and result write-back.

Device alarms, task near-due reminders, overdue reminders, pending approvals, and abnormal-result confirmations are actionable reminders and must not be designed as ordinary notifications only.

Minimum required context:

- 页面所属行业或业务场景
- 使用角色
- 核心数据对象
- 高频操作
- 必要状态
- 权限或流程要求

## Explanation Rules

- Use right-side Drawer for explanations.
- Use unified small circular `i` / `ⓘ` icon.
- Do not mix explanation icons with business buttons, filters, status tags, pagination, search, or view controls.
- Repeated components share one component-level explanation only when their business meaning, function, data meaning, interaction, role, state, permission, workflow, and risk are materially the same.
- If the same visual component carries different functions, data meanings, roles, states, permissions, workflows, or risks, provide separate explanations.













