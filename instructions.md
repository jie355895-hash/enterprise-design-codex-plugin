# Execution Instructions

## Project Safety and Structure

Use `业务内容文档`, `Demo`, `原型`, and `技术依赖` as the four project content folders. Keep plugin-control files and required program files under `CODEX_PLUGIN_DO_NOT_EDIT`.

Folder mapping: business documents and screenshots go to `业务内容文档`; generated pages and Demo assets go to `Demo`; source prototypes and prototype logic go to `原型`; packages, lock files, build tools, and third-party dependencies go to `技术依赖`. Plugin rules, control records, checklists, version files, and required scripts go to `CODEX_PLUGIN_DO_NOT_EDIT`.

Prototype/Demo boundary: keep editable design sources and interaction logic in `原型`; keep runnable or reviewable exported pages and assets in `Demo`. Do not maintain two independent versions. The Demo must record its prototype source and version relationship.

## Prototype-to-Demo Synchronization

After a prototype change, first compare the prototype and Demo and output the differences, affected files, and modification plan. Wait for user confirmation. Only then update the Demo, run the after-checklist, and record the Demo version, prototype source/version, change notes, and pending items.

## Demo Version Control

Never overwrite a confirmed Demo. Create a new version under `Demo/versions/`, preserve earlier versions as read-only, and mark a version as `current` only after user confirmation and review. Record previous version, prototype source/version, changes, confirmation status, and pending items in `version.json`.

## All Output Version Control

The same versioning rule applies to business documents, prototypes, Demos, and technical dependency/configuration outputs. Preserve the previous confirmed version, create a new version, record source, reason, change summary, reviewer, confirmation state, and pending items, and never overwrite a confirmed output in place.

New projects start with only the four first-level output folders. Create child folders such as `versions` only when actual output or a version change requires them.

统一版本目录：`业务内容文档\versions\vX.Y`、`Demo\versions\vX.Y`、`原型\versions\vX.Y`、`技术依赖\versions\vX.Y`。每个版本目录包含输出物和`version.json`；`CODEX_PLUGIN_DO_NOT_EDIT\output-version-manifest.json`记录各类输出物的当前版本。首次输出可暂存在正常业务目录，首次确认后必须建立版本目录。回滚必须创建新版本，不能删除历史版本。

Before reorganizing files, back up the project. Never delete or overwrite project outputs during synchronization. Stop when names collide on Windows, files are locked, destinations already exist, or the source is uncertain.

## Conversation-Driven Knowledge and Rule Updates

The user does not maintain this system by manually editing folders. A request made in the Codex conversation is the update instruction.

The independently updateable scopes are:

1. 中央知识库
2. 插件规则
3. 项目创建模板
4. 项目创建工具
5. 同步工具
6. 工作区上下文
7. 所有子项目的插件控制文件

Every update follows a staged confirmation gate:

1. Read the evidence and identify the requested target scope.
2. Output the target change proposal, evidence, version impact, and explicit out-of-scope items.
3. Wait for user confirmation before changing the target.
4. After the target changes, assess all seven scopes.
5. Classify each other scope as `必须更新`, `建议更新`, `无需更新`, or `待确认`.
6. Show concrete content for linked changes and wait for confirmation before applying them.
7. Preserve prior versions, back up projects, synchronize only confirmed project-control files, and verify final alignment.

Learning reference knowledge and mandatory plugin behavior are separate. If both are requested, confirm their contents separately before writing either one.

The user must not be told to manually create, edit, copy, move, or delete files, or to run a console command. The user-facing project tool only creates new projects; Codex performs confirmed maintenance internally.

## User-Facing Language

默认使用中文完成所有面向用户的提问、分析、文字确认稿、Demo 说明、评审、版本记录说明和错误提示。只有用户明确要求其他语言时才切换语言。代码、文件名、API 和必要技术关键词可保留原文。

## Design Capability and UI Library Usage

UI规范主要参考Ant Design 5、Carbon Design System和WCAG 2.2。中央知识库只提供业务领域参考，不提供默认颜色、字体、布局、间距或组件规范。`ui-ux-pro-max`用于视觉方向、风格探索、交互质量和AI评审。

默认新Demo使用1920×1080画布、24栅格、8px基础单位、14px基础字号、32px基础控件高度和6px基础圆角。默认语义色采用Ant Design 5 Token；已有项目品牌、UI规范和确认PRD优先。

使用`daisyUI`仅限HTML + Tailwind Demo；使用`shadcn/ui`仅限React + Tailwind项目；Vue 3 + Tailwind在没有既有组件体系时使用`shadcn-vue`。已有项目技术和组件系统优先，一个Demo只使用一个主要组件体系。

Demo评审按WCAG 2.2 AA检查对比度、键盘焦点、交互目标、状态表达、表单标签和焦点遮挡问题。

## Official Product Design Capability Coordination

The Enterprise Design Plugin is the governing workflow. Official Product Design capability may support screenshot analysis, visual exploration, prototypes, frontend Demos, screenshot-to-code, and UX review. New or changed product outputs require research, the text design draft, and the PRD design file to be confirmed first. Review-only tasks may inspect existing evidence and report findings without generating a new PRD or Demo. After production, return for enterprise role, permission, industrial-system, Drawer, notification, Demo-note, user-experience, and version review.

执行产品设计任务：

需求接收与识别
→需求调研与证据收集
→领域识别与中央知识库检索
→需求定义与范围确认
→需求澄清
→业务分析
→方案设计
→文字版确认稿
→用户确认
→PRD设计文件
→PRD确认
→Demo生成
→根据PRD生成Demo内说明
→Demo自动检查与AI评审
→用户查看、点击和体验验收
→迭代与版本保存

任务分支：已有PRD未生成Demo时复核PRD后进入Demo；已确认PRD的纯视觉/交互修订先输出差异和影响，确认后生成新Demo版本；原型同步Demo按差异确认流程执行；评审/审计任务只检查和输出结论，不自动生成PRD或Demo。

## 需求澄清门槛

需求澄清不是可跳过步骤。

在生成 Demo 前必须完成信息完整度判断：

- 完整：说明依据，并继续生成
- 部分完整：先提出最少必要的关键问题，或列出默认假设并等待用户确认
- 不完整：禁止直接生成 Demo，必须先提问

需求调研和已有项目文件应优先补足以下信息；只有在这些信息缺失且会改变设计时，才向用户提问：

1. 页面所属行业或业务场景
2. 使用角色
3. 核心数据对象
4. 高频操作
5. 必要状态
6. 权限或流程要求
7. 产品形态：后台、工作台、大屏、LIMS、MES、IoT、数字孪生、质量检测、试验管理或设备资产

## 需求调研与PRD

需求识别回答用户提出了什么；需求调研还要分析为什么做、为谁做、当前流程、现有问题、依据、范围和约束。调研材料可以来自业务文档、截图、原型、现有页面、角色岗位、菜单、流程规则、权限配置、项目文件和中央知识库。

文字版确认稿确认后必须生成PRD设计文件。PRD至少包含目标、范围、角色、入口、数据、字段、页面结构、操作、权限、状态、流程、异常、通知、说明内容、视觉方向、Demo交互要求、Demo验收标准、依据、假设和待确认项。

PRD生成后必须等待用户确认。未确认PRD不得生成Demo。PRD是Demo页面、交互、状态、权限和页面内说明的产品依据。

## 产品形态判断

生成方案前必须先判断产品形态。

不得默认所有 SaaS 工业系统页面都是后台列表详情。

产品形态会影响：

- 页面结构
- 信息密度
- 可视化方式
- 交互频率
- 实时性要求
- 角色关注点
- 说明 Drawer 覆盖对象
- Demo 风格

如果产品形态不明确，且会影响布局、组件、图表、实时数据或流程设计，必须先澄清。

如果需求是大屏，必须优先确认：

- 展示场景：指挥中心、车间屏、会议汇报、管理驾驶舱
- 屏幕比例和分辨率
- 实时/准实时数据
- 核心指标
- 告警规则
- 是否需要地图、产线、设备拓扑或趋势图

如果需求是 LIMS，必须优先确认：

- 样品类型
- 检测项目
- 实验流程
- 结果录入与复核
- 报告生成
- 合规留痕
- 角色权限

## 消息提醒设计

如果页面包含消息、通知、提醒、报警、预警、临期、超期等能力，必须先区分：

- 正常提醒
- 需处理的提醒

正常提醒以知晓为主。

需处理的提醒必须形成处理闭环：

- 触发对象
- 触发规则
- 严重等级
- 触发时间/截止时间
- 责任角色
- 去处理入口
- 处理页面或流程
- 状态流转
- 处理结果回写

设备报警、任务临期、任务超期、异常待确认等必须归为需处理提醒，不得只作为普通消息展示。

## 角色驱动设计

使用角色必须参与方案判断，不得只作为文字说明。

本插件默认服务 SaaS 类工业系统。角色判断必须结合租户、公司、组织、工厂、岗位、数据权限和流程权限。

需要判断：

- 该角色进入页面的目标是什么
- 该角色最常用的操作是什么
- 该角色能看到哪些数据
- 该角色能操作哪些按钮
- 该角色参与哪些流程节点
- 该角色需要优先看到哪些状态或预警
- 该角色需要哪些说明内容辅助理解、研发、测试和验收
- 该角色从哪个菜单或工作台入口进入页面
- 该角色默认看到哪个视图、筛选条件或数据范围
- 该角色是否跨公司、跨工厂、跨部门或跨项目查看数据

如果一个页面面向多个角色，必须说明：

- 共用内容
- 角色差异
- 权限差异
- 默认视图差异
- 操作入口差异
- 页面入口差异
- 数据范围差异
- 内容区块显隐差异

同一个公司、同一个模块、同一个页面中，不同角色也可能看到完全不同的数据、操作、页面内容和页面入口。

设计时必须输出角色差异矩阵，至少覆盖：

- 角色
- 页面入口
- 数据范围
- 可见内容
- 可用操作
- 默认视图
- 流程职责
- 依据来源

若角色差异会影响页面结构，必须在文字版确认稿中先确认，不得直接生成 Demo。

不得自己想象角色权限。

如果没有权限配置、PRD、截图、菜单、原型、流程规则或用户明确说明作为依据，角色可见页面、可见数据、可用操作都必须标记为“待确认”或“默认假设”。

## Demo 说明要求

生成 Demo 后，必须根据已确认PRD同步生成Demo页面内说明和Demo说明。

Demo 说明必须包含：

- 角色差异矩阵
- 依据来源
- 默认假设
- 待确认项
- 数据范围说明
- 页面入口说明
- 操作权限说明
- 流程权限说明
- PRD文件路径、PRD版本和Demo来源关系

如果Demo需要的说明在PRD中没有依据，必须标记为待确认或先补充PRD，不得自行编造。

不得只在对话中说明，必须沉淀到 Demo 说明文件或页面说明区域中。

如果用户只说“做一个 XX 页面 Demo”，默认判定为“部分完整或不完整”，必须先问问题。

澄清问题数量不设固定限制。

原则：

- 只问影响方案方向、业务规则、字段、权限、流程、状态的关键问题
- 已能从项目文件、截图、PRD、原型、历史上下文判断的信息不重复问
- 简单需求可以只问 1 个问题
- 复杂需求可以分批提问，避免一次性问题过多
- 不为满足数量而凑问题

## Demo 前文字确认

如果没有必要继续提问，不能直接生成 Demo。

必须先输出文字版确认稿，等待用户确认。

文字版确认稿用于让用户确认：

- 需求理解是否正确
- 页面结构是否正确
- 字段、操作、状态、权限、流程是否正确
- 说明 Drawer 覆盖对象是否正确
- 默认假设是否可接受

用户确认后，才可进入 Demo 生成、说明补充、AI评审和版本保存。

确认状态统一记录为：`草稿`、`待确认`、`部分确认`、`需修改`、`已确认`、`已暂停`、`已拒绝`、`当前`、`已归档`。当用户只表达“大体可以”“继续”等模糊意见，且仍有影响页面结构、权限、流程、状态或数据的待确认项时，不得标记为`已确认`。

说明对象：

模块
页面
区域
字段
按钮
状态
流程节点
数据指标

## 说明范围判断

说明是否增加，必须综合业务复杂度、功能用途、数据含义、使用角色、状态、权限、流程、风险和易误解程度判断。

- 重复视觉组件只有在业务含义、功能、数据、交互、角色、状态和权限基本一致时，才合并为组件级说明。
- 同一组件如果承载不同业务功能、数据含义、角色、状态、权限、流程或风险场景，必须分别提供对应说明。
- 说明入口统一使用圆形 `i` / `ⓘ` 和右侧 Drawer，不与业务按钮、筛选、状态标签、分页或搜索混合。
- 不以减少或增加说明图标数量为目标，以保证用户正确理解和操作为目标。


