# 🍔 麦麦全能管家 · McButler

> 基于 **麦当劳中国 MCP（mcp.mcd.cn）** 的一站式智能助手 Skill —— 帮你省钱、吃好、用好积分、顺手点单。
> 本项目的参赛作品，非麦当劳官方产品；输出仅供参考，以官方实时数据为准。所有产出统一为可口可爱风 HTML 页面，可直接在浏览器预览/分享。麦报内每个动作均带「🤖 去 WorkBuddy 执行」按钮，点一下复制指令、去 WorkBuddy 发送即可执行（下单/领券前会先确认）。

---

## ✨ 功能特性（五大能力）

| # | 能力 | 一句话 | 核心 MCP 工具 |
|---|---|---|---|
| 1 | 🗞️ **今日麦报** | 每日自动推送：可领券 + 当月活动 + 最省吃法 | `available-coupons` / `auto-bind-coupons` / `query-store-coupons` / `campaign-calendar` / `query-meals` / `calculate-price` |
| 2 | 💰 **省钱雷达** | 自动领麦麦省券、比门店券、算最省组合 | `query-my-coupons` / `query-store-coupons` / `available-coupons` / `calculate-price` |
| 3 | 🥗 **热量营养师** | 按每日热量预算（默认 500 kcal）配麦当劳套餐 | `list-nutrition-foods` / `query-meals` / `query-meal-detail` / `calculate-price` |
| 4 | ⭐ **积分最优解** | 积分怎么换最值、抽奖策略与核对 | `query-my-account` / `mall-points-products` / `mall-product-detail` / `query-lottery-info` / `draw-lottery` / `query-my-prizes` |
| 5 | 🛵 **一句话点餐** | 自然语言选店选品算价下单（下单前强制确认） | `query-nearby-stores` / `delivery-query-addresses` / `query-meals` / `calculate-price` / `create-order` |

> 所有数据均来自麦当劳 MCP 实时返回，不编造、不缓存旧价。

---

## 📁 项目结构

```
mcd-butler/
├── SKILL.md                  # 核心：WorkBuddy Skill 定义（能力、调用流程、安全约束）
├── README.md                 # 本文件：项目介绍、安装、使用示例
├── MCP_INTEGRATION.md        # MCP Server / Tool / 调用流程 / 业务价值说明
├── CONTEST_DECLARATION.md    # 参赛声明（活动要求，内容不可改动）
├── mcp-config.example.json   # 脱敏配置示例（仅环境变量占位符）
├── daily-report/
│   └── automation.example.json  # 今日麦报「每日自动推送」自动化配置示例
└── workbuddy.md              # WorkBuddy 开发上下文（联动奖励核验用）
```

---

## 🚀 安装与配置

### 1. 申请麦当劳 MCP Token
前往 [open.mcd.cn/mcp](https://open.mcd.cn/mcp) → 右上角登录（手机号验证）→ 控制台 → 激活 → 复制 Token。

### 2. 在 WorkBuddy 配置 mcd-mcp 连接器
左侧「专家·技能·连接器」→「连接器」→「自定义连接器」→「配置 MCP」，粘贴：

```json
{
  "mcpServers": {
    "mcd-mcp": {
      "type": "streamablehttp",
      "url": "https://mcp.mcd.cn",
      "headers": {
        "Authorization": "Bearer ${MCD_MCP_TOKEN}"
      }
    }
  }
}
```

> 将 `${MCD_MCP_TOKEN}` 替换为你的真实 Token（或写入环境变量后由客户端展开）。**请勿把真实 Token 提交进仓库。**

### 3. 启用 Skill
将本仓库作为 WorkBuddy 用户级 / 项目级 Skill 安装，或在对话中直接引用 `SKILL.md` 内容即可。

### 4.（可选）开启「今日麦报」每日自动推送
见 `daily-report/automation.example.json`，在 WorkBuddy 创建一个每日定时自动化，prompt 为「生成今日麦报并推送」。

---

## 💬 使用示例

**今日麦报**
> 用户：来份今日麦报
> 管家：🎟️ 可领 9 张（已帮你领）｜📅 夜市买一送一｜🍔 最省：双层吉士套餐≈¥29.9｜⭐ 积分 3200，建议换薯条券

**省钱雷达**
> 用户：今晚怎么吃最省？
> 管家：（领券+比价）用麦麦省券 + 门店券，板烧套餐立省 ¥10，到手 ¥25.5

**热量营养师**
> 用户：500 大卡怎么吃？
> 管家：（营养库+菜单匹配）麦香鸡 + 玉米杯 ≈ 480 kcal / ¥18.5

**积分最优解**
> 用户：积分怎么换最值？
> 管家：（比价）3200 积分换「麦辣鸡腿堡兑换券」性价比最高，另有 800 积分即将过期

**一句话点餐**
> 用户：点个板烧套餐送到公司
> 管家：A 门店，合计 ¥35.5，送至「公司」。确认下单吗？ →（确认后）✅ 订单 #xxxx

---

## 🎯 目标用户

- 经常吃麦当劳、想省钱的打工人
- 减脂/健身期仍想偶遇麦当劳的用户
- 积分囤积、想最大化兑换价值的人
- 懒得翻 App、偏好「说一句话就搞定」的点餐党

---

## 🏆 参加「麦当劳程序员创意开发大赛」

- 仓库需为 **Public**，创建时间在 2025-12-25 ~ 2026-10-25。
- 必须包含：`README.md`、`CONTEST_DECLARATION.md`（不可改）、`MCP_INTEGRATION.md`、`mcp-config.example.json`（仅环境变量）、`workbuddy.md`（参与 WorkBuddy 奖励时）。
- 报名：在官方仓库发 Issue，正文：
  ```
  【参赛申请】
  项目名称：麦麦全能管家 McButler
  项目地址：https://github.com/<你的账号>/mcd-butler
  项目简介：基于麦当劳 MCP 的一站式智能助手，涵盖今日麦报/省钱雷达/热量营养师/积分最优解/一句话点餐五大能力
  ```
- 排名按 GitHub 公开 Star 数，前 100 进获奖区。

---

## ⚠️ 免责声明

本项目为麦当劳程序员节创意开发大赛参赛作品，由参赛者独立开发，**非麦当劳官方产品**。项目输出仅供参考，不构成医疗、营养或专业建议；餐品信息、价格与供应状态以麦当劳官方渠道实时结果为准。
