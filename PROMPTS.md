# MCP Server Prompts

本 MCP 服务器提供以下预定义 prompts,帮助用户快速完成常见任务。

## 可用 Prompts

### 1. convert-taobao-link
**描述**: 将淘宝商品链接转换为推广链接

**参数**:
- `url` (必需): 原始淘宝商品链接

**用途**: 快速将淘宝商品链接转换为带推广参数的链接

**示例**:
```
使用 convert-taobao-link prompt
url: https://item.taobao.com/item.htm?id=123456789
```

---

### 2. search-products
**描述**: 跨平台搜索商品

**参数**:
- `keyword` (必需): 搜索关键词
- `platform` (可选): 平台选择 (taobao/jd/pdd),默认搜索所有平台

**用途**: 在多个电商平台同时搜索商品

**示例**:
```
使用 search-products prompt
keyword: iPhone 15
platform: taobao
```

---

### 3. generate-promotion
**描述**: 生成商品推广链接和素材

**参数**:
- `platform` (必需): 平台 (taobao/jd/pdd)
- `itemId` (必需): 商品ID
- `includeQRCode` (可选): 是否生成二维码,默认 false

**用途**: 为指定商品生成完整的推广方案,包括链接、淘口令等

**示例**:
```
使用 generate-promotion prompt
platform: taobao
itemId: 123456789
includeQRCode: true
```

---

### 4. check-orders
**描述**: 查询指定时间段的订单

**参数**:
- `platform` (必需): 平台 (taobao/jd/pdd)
- `startDate` (必需): 开始日期 (YYYY-MM-DD)
- `endDate` (可选): 结束日期 (YYYY-MM-DD),默认为今天

**用途**: 批量查询订单数据

**示例**:
```
使用 check-orders prompt
platform: taobao
startDate: 2024-01-01
endDate: 2024-01-31
```

---

## 如何使用 Prompts

### 在 Claude Code 中使用
```bash
# 列出所有可用的 prompts
mcp prompt list

# 使用特定的 prompt
mcp prompt get convert-taobao-link --arg url="https://item.taobao.com/item.htm?id=123456789"
```

### 在 MCP 客户端中使用
```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "method": "prompts/get",
  "params": {
    "name": "convert-taobao-link",
    "arguments": {
      "url": "https://item.taobao.com/item.htm?id=123456789"
    }
  }
}
```

## 实现说明

Prompts 由服务器端实现,客户端通过 MCP 协议调用。每个 prompt 会:

1. **验证参数**: 检查必需参数是否提供
2. **调用相关工具**: 自动组合多个工具完成复杂任务
3. **格式化输出**: 返回格式化的结果,便于用户理解

## 扩展 Prompts

开发者可以通过修改服务器代码添加新的 prompts:

```typescript
// 在 server-manager.ts 或相关文件中
mcpServer.prompt(
  'prompt-name',
  'Prompt description',
  {
    param1: z.string(),
    param2: z.string().optional()
  },
  async (args) => {
    // 实现 prompt 逻辑
    return {
      messages: [
        {
          role: 'user',
          content: {
            type: 'text',
            text: 'Prompt result'
          }
        }
      ]
    };
  }
);
```
