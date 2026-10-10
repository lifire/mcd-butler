# MCP 集成说明（MCP_INTEGRATION.md）

本文件说明本项目真实使用的麦当劳 MCP Server、Tool、调用流程与业务价值，符合《麦当劳程序员创意开发大赛活动规则》对参赛项目「须真实使用麦当劳 MCP 能力」的要求。

---

## 1. 接入的 MCP Server

| 项 | 值 |
|---|---|
| 服务方 | 麦当劳中国（金拱门） |
| 接入地址 | `https://mcp.mcd.cn` |
| 传输协议 | Streamable HTTP |
| 鉴权 | 请求头 `Authorization: Bearer <MCP_TOKEN>` |
| 配置示例 | 见 `mcp-config.example.json`（仅 `${MCD_MCP_TOKEN}` 占位符） |
| 官方仓库 | https://github.com/M-China/mcd-mcp-server |
| 限频 | 每 Token 600 次/分钟（超量 429，需退避） |

---

## 2. 实际使用的 Tool 与调用流程

### 能力一：今日麦报（daily digest）
```
now-time-info
  → available-coupons          # 麦麦省可领券列表
  → auto-bind-coupons          # 一键领取（确认后）
  → query-store-coupons        # 当前门店可用券
  → campaign-calendar          # 当月营销活动
  → query-meals + calculate-price  # 结合券算最省组合
```
**业务价值**：把分散在多个入口的「券 / 活动 / 菜单」聚合为一份每日可读的省钱情报，降低用户决策成本。

### 能力二：省钱雷达
```
query-my-coupons → query-store-coupons → available-coupons
  → auto-bind-coupons（确认后）
  → query-meals → query-meal-detail → calculate-price（带入可用券）
```
**业务价值**：自动归集并比价各类券，输出「最省方案 + 节省金额」，直接可转化为下单。

### 能力三：热量营养师
```
list-nutrition-foods → query-meals → query-meal-detail → calculate-price
```
**业务价值**：将营养数据库与实时菜单交叉匹配，按用户热量预算生成可下单套餐，服务减脂/健身人群。

### 能力四：积分最优解
```
query-my-account
  → mall-points-products → mall-product-detail     # 积分兑换比价
  → query-lottery-info → draw-lottery → query-my-prizes  # 抽奖策略与核对
```
**业务价值**：帮助用户把积分花在「性价比最高 / 即将过期」的刀刃上，并提供抽奖辅助。

### 能力五：一句话点餐（高风险，强制确认）
```
query-nearby-stores / delivery-query-addresses
  → query-meals → query-meal-detail
  → calculate-price
  → 【用户确认】→ create-order
  → query-order（跟踪）
```
**业务价值**：用自然语言完成「选店→选品→算价→下单」全链路，下单前强制二次确认防误触。

---

## 3. 安全与合规要点

- **Token 不落盘、不回显**：配置只使用 `${MCD_MCP_TOKEN}` 环境变量占位符（见 `mcp-config.example.json`）。
- **写操作前置确认**：`create-order` / `draw-lottery` / `mall-create-order` / `auto-bind-coupons` 均在用户明确确认后调用。
- **限频保护**：批量调用控制频率，遇 `429` 退避重试，避免触发封禁。
- **内容合规**：不对比/贬低其他品牌，不涉敏感内容，遵守麦当劳 MCP 服务规则与活动规则。

---

## 4. 业务价值总结

麦麦全能管家把麦当劳 MCP 在「券、活动、菜单、营养、积分、点餐」六大场景的能力缝合为一个统一入口，
让用户用**一句话**完成过去需要在 App 里跳转多次的操作，并以「今日麦报」提供持续价值，提升复访与口碑传播（Star）潜力。
