# 贡献指南

感谢您对觉照验证器项目的关注！我们欢迎各种形式的贡献，包括但不限于：

- 🐛 Bug 修复
- ✨ 新功能
- 📚 文档改进
- 🌐 翻译
- 💡 改进建议

## 开发环境

### 环境要求

- HarmonyOS SDK 4.0+
- DevEco Studio 4.0+
- Node.js 18+
- ohpm（鸿蒙包管理器）

### 快速开始

```bash
# 1. Fork 本仓库

# 2. 克隆你的 Fork
git clone https://github.com/YOUR_USERNAME/juezhao-authenticator-harmonyos.git
cd juezhao-authenticator-harmonyos

# 3. 添加上游仓库
git remote add upstream https://github.com/weinotes/juezhao-authenticator-harmonyos.git

# 4. 创建开发分支
git checkout -b feature/your-feature-name

# 5. 安装依赖
cd harmonyos/juezhao_authenticator
ohpm install

# 6. 开始开发
# 使用 DevEco Studio 打开 harmonyos/juezhao_authenticator 目录

# 7. 构建测试
hvigor assembleDebug

# 8. 提交更改
git commit -m "feat: 添加新功能描述"

# 9. 推送分支
git push origin feature/your-feature-name

# 10. 创建 Pull Request
```

## 代码规范

### ArkTS 编码规范

1. **命名规范**
   - 类名：`UpperCamelCase`（如 `TOTPService`）
   - 方法名：`lowerCamelCase`（如 `generateTOTP`）
   - 常量：`UPPER_SNAKE_CASE`（如 `AES_KEY_ALIAS`）
   - 文件名：`lower_snake_case.ets`（如 `totp_service.ets`）

2. **组件规范**
   - 使用 `@Component` 装饰的 UI 组件放在 `components/` 目录
   - 使用 `@Entry` 装饰的页面放在 `pages/` 目录
   - 业务服务放在 `services/` 目录
   - 工具类放在 `utils/` 目录
   - 数据模型放在 `models/` 目录

3. **类型安全**
   - 尽量使用显式类型声明
   - 避免使用 `any` 类型
   - 优先使用 `@Observed` 和 `@ObjectLink` 进行响应式更新

### Git 提交规范

我们使用 [Conventional Commits](https://www.conventionalcommits.org/) 规范：

```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

**类型 (type)**：
- `feat` - 新功能
- `fix` - Bug 修复
- `docs` - 文档变更
- `style` - 代码格式（不影响功能）
- `refactor` - 重构（不影响功能）
- `perf` - 性能优化
- `test` - 测试相关
- `chore` - 构建/工具相关

**示例**：

```
feat(services): 添加 TOTP 验证码生成功能

- 实现 HMAC-SHA1 算法
- 支持 6 位和 8 位验证码
- 支持 30 秒和 60 秒刷新周期

Closes #123
```

## Pull Request 流程

### 创建 PR 之前

1. 确保代码通过构建
2. 确保通过所有测试
3. 更新相关文档（如有必要）
4. 确保提交信息清晰规范

### PR 描述模板

```markdown
## 描述
简要说明这个 PR 的目的

## 更改内容
- 列出主要更改
- 如果有多个更改点，使用列表

## 测试
描述如何测试这些更改

## 截图（如有 UI 更改）
[在此处添加截图]

## Checklist
- [ ] 代码遵循项目编码规范
- [ ] 自测通过
- [ ] 文档已更新（如需要）
- [ ] 提交信息符合规范
```

### Review 流程

1. 至少需要 1 位维护者 Review
2. 所有 Review 通过后才会合并
3. 如果有冲突，需要先解决冲突

## 分支策略

- `main` - 稳定分支，始终保持可发布状态
- `develop` - 开发分支，包含下一个版本的更改
- `feature/*` - 功能分支，从 develop 创建
- `fix/*` - 修复分支，从 main 或 develop 创建
- `hotfix/*` - 紧急修复分支，从 main 创建

## 开发指南

### 添加新页面

1. 在 `entry/src/main/ets/pages/` 创建新页面 `.ets` 文件
2. 在 `entry/src/main/resources/base/profile/main_pages.json` 中注册页面
3. 使用 `@Entry` 和 `@Component` 装饰器

### 添加新服务

1. 在 `entry/src/main/ets/services/` 创建服务 `.ets` 文件
2. 使用 `export class` 导出
3. 使用 `static` 方法或单例模式

### 添加国际化字符串

1. 在 `AppScope/resources/base/element/string.json` 添加字符串
2. 使用 `$r('app.string.name')` 引用

## 问题反馈

如果您发现任何问题，请创建 Issue：

- 🐛 Bug 报告：使用 Bug Report 模板
- ✨ 功能请求：使用 Feature Request 模板
- ❓ 其他问题：使用 General Issue 模板

## 许可证

参与本项目即表示您同意将您的贡献按照 [Apache-2.0](LICENSE) 许可证开源。

---

再次感谢您的贡献！🌟
