# External UI Design Reference

本文件是外部成熟 UI 体系的参考摘要，不是中央业务知识库。中央知识库只用于业务领域参考，不用于决定 UI 颜色、字体、布局、间距或组件样式。

## Reference hierarchy

1. Ant Design 5：企业级产品设计价值、布局、颜色、字体、数据展示、表格、列表和详情页。
2. Carbon Design System：数据表格、批量操作、数据可视化、颜色和可访问性补充。
3. WCAG 2.2：对比度、键盘焦点、交互目标、非颜色信息表达和可访问性基线。
4. ui-ux-pro-max：视觉探索、产品风格选择、交互质量和 Demo 评审。
5. 项目确认的 PRD、品牌规范和已有 UI 规范：覆盖企业默认值。

## Default baseline

- Default canvas: 1920 x 1080
- Layout grid: 24 columns
- Base spacing unit: 8px
- Compatible desktop widths: 1440, 1366, 1280
- Base font size: 14px
- Base control height: 32px
- Base radius: 6px
- Primary: #1677FF
- Success: #52C41A
- Warning: #FAAD14
- Error: #FF4D4F
- Layout background: #F5F5F5
- Text: rgba(0,0,0,0.88)
- Secondary text: rgba(0,0,0,0.65)
- Border: #D9D9D9

These are new-Demo defaults only. Existing project brand and confirmed design values take priority.

## Layout and page patterns

- Choose the page pattern from the task: list, table, detail, form, dashboard, workbench, board, timeline, tree, monitor, or big screen.
- Order content by importance, operation frequency, and relationship.
- Use tables for structured comparison, lists for scanning, cards for light information blocks, and charts for an explicit analytical question.
- Keep fixed navigation, drawers, dialogs, and bottom bars from obscuring focused or primary content.
- Do not make every page a list-detail page or every section a nested card.

## Data table and visualization

- Table toolbars hold global search, filters, export, column settings, and global actions.
- Batch action bars appear after selection.
- Row actions stay inline when few; use overflow when many.
- Pagination belongs at the bottom of a table.
- Expandable rows hold supplementary information, not a second full page.
- Choose chart type by purpose: comparison, trend, part-to-whole, distribution, correlation, time, spatial, or status.
- Charts must expose title, definition, source, time range, unit, refresh time, threshold, legend, and drill-down when applicable.
- Critical information cannot rely on hover or color alone; provide text, icon, table, or detail access.

## Accessibility baseline

- Target WCAG 2.2 AA for Demo review.
- Normal text contrast: at least 4.5:1.
- Large text contrast: at least 3:1.
- Web pointer target: at least 24 x 24 CSS px.
- Touch/PDA critical target: preferably 44 x 44px.
- Keyboard focus must be visible and not obscured.
- Do not convey status by color alone.
- Forms need labels and actionable errors.
- Modal and Drawer focus order must be logical.

## Technology routing

- React + Tailwind: shadcn/ui.
- Vue 3 + Tailwind: shadcn-vue when the project has no established component system.
- HTML + Tailwind: daisyUI.
- Existing component system: keep it unless migration is explicitly confirmed.
- Use one primary component system per Demo; share tokens and interaction rules across stacks.

