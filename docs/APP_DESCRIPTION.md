# 华为应用市场上架描述 | Huawei App Gallery Description

## 应用信息 | App Information

| 项目 | 内容 |
|------|------|
| 应用名称 | 觉照验证器 |
| 英文名称 | juezhao-authenticator |
| 应用 ID | 待分配 |
| 包名 | com.juezhao.authenticator |
| 版本号 | 1.0.0 |
| 最低版本 | HarmonyOS NEXT |
| 应用分类 | 工具 > 安全工具 |
| 开发商 | 觉照科技 |

## 应用图标 | App Icon

- **格式**：PNG
- **尺寸**：1024 × 1024 像素
- **要求**：纯色背景，图标清晰，无文字

## 简短描述 | Short Description

**中文（26-200字符）：**

> 觉照验证器是一款安全的离线双因素认证器，完全兼容Google Authenticator，采用硬件级加密存储密钥，保护您的账号安全。无需网络，密钥永不离开设备。

**英文（26-200字符）：**

> Secure offline 2FA authenticator compatible with Google Authenticator. Hardware-encrypted key storage protects your accounts. No network required, keys never leave device.

## 详细描述 | Full Description

### 中文详细描述（500-5000字）

**【基础信息】**

觉照验证器是一款专为 HarmonyOS NEXT 系统开发的离线双因素认证（2FA）应用。应用完全兼容 Google Authenticator、Microsoft Authenticator 等主流验证器采用的 RFC 6238 TOTP 标准，您可以无缝迁移现有账号。

**【核心功能】**

1. **离线验证**
   - 无需网络连接，完全离线运行
   - 密钥数据仅存储在您设备的本地存储中
   - 不向任何服务器传输任何数据

2. **安全加密**
   - 采用 HUKS 通用密钥体系进行密钥管理
   - 使用 AES-256-GCM 军用级加密算法
   - 密钥存储在设备 TEE（可信执行环境）安全区域
   - 符合国家密码管理局 GM/T 0028、GM/T 0030 规范

3. **扫码添加**
   - 支持扫描 Google Authenticator 等应用生成的二维码
   - 兼容 otpauth:// 协议
   - 自动识别账号信息

4. **实时同步**
   - 30 秒自动刷新验证码
   - 精确到秒的倒计时显示
   - 无需手动刷新

**【支持范围】**

支持的验证器类型：
- TOTP（基于时间的一次性密码）
- 6 位或 8 位验证码
- 30 秒或 60 秒刷新周期
- HMAC-SHA1 / SHA256 / SHA512 算法

**【隐私保护】**

我们郑重承诺：
- 不申请任何网络权限
- 不收集任何用户信息
- 不包含任何广告或追踪器
- 不向第三方提供任何数据

**【适用场景】**

适用于需要双因素认证的所有场景：
- 社交媒体账号（微博、微信等）
- 金融账户（银行、支付等）
- 邮箱账号（Gmail、Outlook 等）
- 云服务（阿里云、腾讯云等）
- 开发工具（GitHub、GitLab 等）

**【使用方法】**

添加账号：
1. 在目标网站开启双因素认证，获取密钥或二维码
2. 打开觉照验证器
3. 选择扫码或手动输入
4. 保存后即可使用

使用验证码：
1. 打开觉照验证器
2. 查看对应账号的 6 位验证码
3. 在目标网站输入验证码完成验证

**【版本历史】**

v1.0.0（2024年）
- 首个正式版本发布
- 支持 TOTP 验证码生成
- 支持二维码扫描添加
- 支持手动输入密钥
- 支持账号管理

**【联系方式】**

官方网站：https://www.juezhaotrade.com
技术支持邮箱：support@juezhaotrade.com
安全漏洞报告：security@juezhaotrade.com

---

### English Full Description

**Basic Information**

juezhao-authenticator is an offline Two-Factor Authentication (2FA) app designed for HarmonyOS NEXT. Fully compatible with RFC 6238 TOTP standard used by Google Authenticator and Microsoft Authenticator, allowing seamless migration of existing accounts.

**Key Features**

1. **Offline Verification**
   - No internet connection required
   - Key data stored locally on device only
   - No data transmission to any servers

2. **Secure Encryption**
   - HUKS universal key management system
   - AES-256-GCM military-grade encryption
   - Keys stored in device TEE (Trusted Execution Environment)
   - Compliant with GM/T 0028 and GM/T 0030 standards

3. **QR Code Scanning**
   - Scan QR codes from Google Authenticator and compatible apps
   - Supports otpauth:// protocol
   - Auto-parse account information

4. **Real-time Sync**
   - 30-second automatic code refresh
   - Second-precision countdown
   - No manual refresh needed

**Supported Types**

- TOTP (Time-based One-Time Password)
- 6 or 8 digit codes
- 30 or 60 second periods
- HMAC-SHA1 / SHA256 / SHA512 algorithms

**Privacy Protection**

We promise:
- No network permissions requested
- No user data collected
- No ads or trackers
- No data shared with third parties

**Contact**

Website: https://www.juezhaotrade.com
Support: support@juezhaotrade.com
Security: security@juezhaotrade.com

## 截图要求 | Screenshots

华为应用市场截图要求：
- 尺寸：建议 1080 × 1920 或 720 × 1280 像素
- 格式：PNG 或 JPG
- 数量：2-20 张
- 内容：应展示应用核心功能界面

建议截图内容：
1. 首页截图（账号列表）
2. 验证码卡片特写
3. 添加账号界面
4. 二维码扫描界面

## 隐私政策 | Privacy Policy

### 中文隐私政策

**觉照验证器隐私政策**

最后更新日期：2024年

**一、信息收集**

觉照验证器不收集任何个人信息。我们不会：
- 收集您的姓名、邮箱、电话等个人信息
- 访问您的通讯录、短信、通话记录
- 追踪您的位置信息
- 分析您的使用行为

**二、信息存储**

- 所有数据（账号名称、验证码）仅存储在您设备的本地存储中
- 密钥使用设备加密芯片加密存储
- 卸载应用后，所有本地数据将被清除

**三、信息共享**

- 我们不会与任何第三方共享您的信息
- 应用不包含任何广告或分析服务
- 无服务器端数据存储

**四、权限使用**

- 相机权限：仅用于扫描二维码添加账号
- 不申请网络权限

**五、用户权利**

- 您可以随时卸载应用清除所有数据
- 您可以导出账号备份（加密格式）

**六、联系我们**

如对本隐私政策有任何疑问，请联系：privacy@juezhaotrade.com

---

### English Privacy Policy

**juezhao-authenticator Privacy Policy**

Last updated: 2024

**1. Information Collection**

juezhao-authenticator does not collect any personal information. We do not:
- Collect your name, email, phone number, etc.
- Access your contacts, messages, call records
- Track your location
- Analyze your usage behavior

**2. Information Storage**

- All data (account names, codes) stored locally on your device
- Keys encrypted using device secure chip
- All local data cleared upon app uninstallation

**3. Information Sharing**

- We do not share your information with any third parties
- No ads or analytics services included
- No server-side data storage

**4. Permission Usage**

- Camera permission: Only for scanning QR codes
- No network permissions requested

**5. Your Rights**

- Uninstall app anytime to clear all data
- Export account backup (encrypted format)

**6. Contact Us**

For privacy concerns, contact: privacy@juezhaotrade.com

## 合规清单 | Compliance Checklist

| 检查项 | 要求 | 状态 |
|--------|------|------|
| 应用图标 | 1024×1024 PNG | ☐ 待提供 |
| 应用截图 | 2-20 张 | ☐ 待提供 |
| 隐私政策 | 必须提供 | ☑ 已准备 |
| 用户协议 | 必须提供 | ☐ 待准备 |
| 安全检测 | 建议通过 | ☐ 待检测 |
| 知识产权证明 | 建议提供 | ☑ 已有 |
| 实名认证 | 开发者需完成 | ☐ 需完成 |

## 开发者信息 | Developer Information

| 项目 | 内容 |
|------|------|
| 开发者名称 | 觉照科技 |
| 开发者类型 | 企业开发者 |
| 营业执照 | 待上传 |
| 联系人 | 待填写 |
| 联系电话 | 待填写 |
| 邮箱 | contact@juezhaotrade.com |
| 地址 | 待填写 |
