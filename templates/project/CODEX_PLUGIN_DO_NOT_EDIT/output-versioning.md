# 全部输出物版本控制

适用范围：业务内容文档、Demo、原型、技术依赖与配置。

统一版本目录：

- `业务内容文档\versions\vX.Y`
- `Demo\versions\vX.Y`
- `原型\versions\vX.Y`
- `技术依赖\versions\vX.Y`

每个版本目录必须包含输出物和`version.json`。`CODEX_PLUGIN_DO_NOT_EDIT\output-version-manifest.json`记录每类输出物的当前版本、路径和上一版本。

每次修改必须：

1. 保留上一个已确认版本。
2. 创建新的版本记录或版本目录。
3. 记录修改原因、来源、变更内容和责任人。
4. 标记确认状态和待确认项。
5. 完成评审和用户确认后再标记为 `current`。
6. 回滚必须创建新版本，不能删除历史版本。

禁止直接覆盖已确认输出物。
