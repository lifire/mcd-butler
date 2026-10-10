# WorkBuddy 开发上下文（workbuddy.md）

> 本文件用于核验本项目真实使用 **腾讯 WorkBuddy 智能体** 开发，符合「麦当劳程序员创意开发大赛」WorkBuddy 专项奖励条件。
> 以下为在 WorkBuddy 中从需求到成品的关键对话上下文摘录（已脱敏，不含任何 Token / 个人信息）。

---

## 1. 需求发起

- 用户请求：报名「麦当劳程序员创意开发大赛」，并先 brainstorm 一个基于麦当劳 MCP 的 Skill 创意。
- 用户已具备资产：麦当劳 MCP Token、公开 GitHub 仓库。
- 用户选定方向：**④ 麦麦全能管家 / 今日麦报**（组合省钱 + 营养 + 积分最优 + 每日自动推送，上限最高的组合型 Skill）。

## 2. 调研（WorkBuddy 联网检索）

WorkBuddy 调用网络检索，核实了以下事实并据此设计：

- **活动规则**：排名仅按 GitHub 公开 Star 数（Star>0 进榜，前 100 进获奖区）；必需文件为 `README.md` / `CONTEST_DECLARATION.md`（不可改）/ `MCP_INTEGRATION.md` / `mcp-config.example.json`（仅环境变量）/ `workbuddy.md`。
- **麦当劳 MCP 真实 Tool 清单**：营养、麦乐送点餐、麦麦省券、积分商城、积分抽奖、活动日历、主题活动、附近门店、时间等 30+ 个工具（来源：M-China/mcd-mcp-server README）。
- **CONTEST_DECLARATION.md 原文**：逐字复用官方声明，未做任何改动。

## 3. 创意与架构决策

- 定为 **WorkBuddy Skill 形态**（一份 `SKILL.md` 引导智能体调用 mcd-mcp 连接器），最契合官方合作伙伴与积分奖励。
- 五大能力拆分：今日麦报 / 省钱雷达 / 热量营养师 / 积分最优解 / 一句话点餐。
- 安全约束：写操作（下单、抽奖、领券、兑换）前置用户确认；Token 仅用 `${MCD_MCP_TOKEN}` 占位符。

## 4. 文件产出（WorkBuddy 生成）

| 文件 | 说明 |
|---|---|
| `SKILL.md` | 核心 Skill：触发描述、连接器自检、能力矩阵、各能力调用流程、输出规范、安全合规、示例对话 |
| `README.md` | 项目介绍、安装配置、使用示例、目标用户、参赛说明 |
| `MCP_INTEGRATION.md` | 接入 Server、Tool 调用流程、业务价值、安全合规 |
| `CONTEST_DECLARATION.md` | 官方参赛声明（逐字复用，未改） |
| `mcp-config.example.json` | 脱敏配置（仅 `${MCD_MCP_TOKEN}`） |
| `daily-report/automation.example.json` | 今日麦报每日自动推送配置示例 |
| `workbuddy.md` | 本文件 |

## 5. 示例对话上下文（节选）

**用户**：来份今日麦报
**WorkBuddy（McButler）**：
> 📅 10/10 今日麦报
> 🎟️ 可领：麦麦省 9 张（已帮你一键领取）
> 📅 活动：麦麦夜市买一送一（至 10/31）
> 🍔 最省吃法：双层吉士套餐 + 夜市券 ≈ ¥29.9（省 ¥10）
> ⭐ 积分：当前 3,200，建议换「薯条兑换券」
> 建议：今晚用夜市券下单最划算～（非官方产品，以实时为准）

**用户**：帮我点个板烧鸡腿堡套餐送到公司
**WorkBuddy（McButler）**：已选 A 门店，板烧鸡腿堡套餐 ¥32.5 + 配送费 ¥3 = **¥35.5**，送至「公司」地址。**确认下单吗？**
**用户**：确认
**WorkBuddy（McButler）**：✅ 下单成功，订单号 #xxxx，支付链接：…（非官方产品，以实时为准）

## 6. 结论

本项目在 WorkBuddy 中完成「需求澄清 → 联网调研 → 创意选型 → Skill 设计与生成 → 参赛文件齐备」全流程，真实依赖 WorkBuddy 智能体能力，满足联动奖励核验要求。
