# 中央知识库检索索引

设计任务开始后，先根据需求关键词检索相关分类，不需要无差别读取全部知识。

| 需求线索 | 优先检索 | 重点内容 |
|---|---|---|
| 实验室、样品、仪器、检测、报告、试验 | `lims` | 领域模型、样品任务、设备、质量、页面模式 |
| 生产、工单、工艺、物料、排产、现场执行 | `mes` | 制造执行、刀具、库存、PDA、设备协同 |
| MES+LIMS、结果回写、批次追溯、跨系统 | `industrial-domain-integration.md` | 数据主责、同步方向、状态映射、异常补偿 |
| 设备、告警、采集、物联网、监控 | `lims/equipment-integration.md`、`mes/fanuc-tlm-reference.md` | 设备数据、责任人、处理闭环 |
| 质量、异常、审批、巡检、报告 | `lims/quality-and-reporting.md`、`mes/fanuc-tlm-reference.md` | 质量流程、审批、异常处理 |
| 页面、交互、视觉、后台、大屏、工作台 | `ui-rules`、`product-rules` | 设计系统、说明 Drawer、工业产品规则 |

| 实验室质量、样品拒收、运输、审核、能力评估 | `lims/laboratory-quality-management-reference.md`、`lims/sample-chain-of-custody-reference.md` | LQMS、样品链路、质量事件和记录 |
| LIMS、LES、ELN、SDMS、CDS、验证、升级、退役 | `lims/laboratory-informatics-lifecycle.md` | 实验室信息化生态与生命周期 |
| 数据完整性、审计追踪、电子签名、OOS | `lims/data-integrity-and-electronic-records.md`、`lims/oos-and-nonconformance-reference.md` | 高风险实验室数据和异常结果 |
| ISO 17025、GLP、21 CFR Part 11、WHO LQMS | `lims/regulatory-profile-reference.md` | 条件适用的质量和监管参考 |
| 通用MES、MOM、ISA-95、生产运营 | `mes/isa95-mom-reference.md` | MES层级、活动模型、对象和接口 |
| MES、LIMS、设备、质量跨域对象和状态 | `industrial-domain-integration.md`、`industrial-domain-integration-matrix.md` | 数据主责、状态映射、补偿和审计 |
| 设备资产、维护、校准、生命周期 | `equipment-asset-lifecycle-reference.md` | 资产管理和设备可用性 |
| OPC UA、工业数据、事件、历史、互操作 | `industrial-data-interoperability-reference.md` | 采集、语义、安全和系统边界 |
| 工业SaaS、主数据、唯一标识、数据权限 | `industrial-saas-and-master-data-reference.md` | 租户、组织、工厂、实验室和跨域主数据 |

## 检索结果记录

每个产品设计任务都要记录：

- 知识库版本
- 检索领域
- 实际读取的文件
- 采用的参考内容
- 明确未采用的内容
- 默认假设
- 待用户确认项

如果没有适用资料，记录：`未找到适用参考知识`。

## 外部来源

本次联网检索和后续新增参考的来源见 `external-sources.md`。外部来源只提供业务借鉴，不自动成为插件强制规则。

