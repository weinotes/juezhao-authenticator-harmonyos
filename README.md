# 觉照验证器
# juezhao-authenticator

<p align="center">
  <img src="docs/images/icon.png" width="120" alt="觉照验证器 Logo" />
</p>

<p align="center">
  <strong>基于 HarmonyOS NEXT 的离线双因素认证器</strong>
</p>

<p align="center">
  <a href="https://github.com/weinotes/juezhao-authenticator-harmonyos/releases">
    <img src="https://img.shields.io/github/v/release/weinotes/juezhao-authenticator-harmonyos?color=007DFF" alt="Release" />
  </a>
  <a href="LICENSE">
    <img src="https://img.shields.io/github/license/weinotes/juezhao-authenticator-harmonyos" alt="License" />
  </a>
  <img src="https://img.shields.io/badge/platform-HarmonyOS%20NEXT-FF512F" alt="Platform" />
</p>

---

## 应用简介 | App Introduction

**【中文】**

觉照验证器是一款基于 HarmonyOS NEXT 的离线双因素认证（2FA）应用，完全兼容 Google Authenticator、Microsoft Authenticator 等主流验证器使用的 RFC 6238 TOTP 标准。

**核心特性：**
- 离线运行 - 无需网络，密钥永不离开设备
- 硬件级加密 - HUKS AES-256-GCM 加密存储
- 扫码添加 - 支持 otpauth:// 协议二维码
- 实时同步 - 30 秒自动刷新验证码

**应用分类：** 工具类 > 安全工具 > 身份验证器

**隐私声明：** 本应用不申请任何网络权限，所有数据仅存储在本地设备。

---

**【English】**

觉照验证器 (juezhao-authenticator) is an offline Two-Factor Authentication (2FA) app built for HarmonyOS NEXT, fully compatible with RFC 6238 TOTP standard used by Google Authenticator and Microsoft Authenticator.

**Key Features:**
- Offline Operation - No network required, keys never leave device
- Hardware-level Encryption - HUKS AES-256-GCM encrypted storage
- QR Code Scanning - Supports otpauth:// protocol
- Real-time Sync - 30-second automatic code refresh

**Category:** Tools > Security > Authenticator

**Privacy:** No network permissions requested. All data stored locally on device.

---

## 上架信息 | Submission Info

| 项目 | 中文 | English |
|------|------|---------|
| 应用名称 | 觉照验证器 | juezhao-authenticator |
| 版本号 | 1.0.0 | 1.0.0 |
| 包名 | com.juezhao.authenticator | com.juezhao.authenticator |
| 最低系统版本 | HarmonyOS NEXT | HarmonyOS NEXT |
| 应用分类 | 工具 > 安全工具 | Tools > Security |
| 字数统计 | 约 3,000 字 | Approx. 3,000 words |

## 安装说明 | Installation

### 方式一：从应用市场安装（推荐）
即将上架华为应用市场，敬请期待。

### 方式二：直接安装 HAP
1. 从 [Releases](https://github.com/weinotes/juezhao-authenticator-harmonyos/releases) 下载最新 HAP 文件
2. 使用 hdc 工具安装：
```bash
hdc install juezhao_authenticator_entry-release-signed.hap
```

### 方式三：自行编译
```bash
# 克隆仓库
git clone https://github.com/weinotes/juezhao-authenticator-harmonyos.git
cd juezhao-authenticator-harmonyos/harmonyos/juezhao_authenticator

# 使用 DevEco Studio 打开并构建
# 或使用命令行
ohpm install
hvigor assembleRelease
```

## 使用教程 | Usage Guide

### 添加账号

**扫码添加：**
1. 在其他验证器应用中获取二维码
2. 打开觉照验证器 → 添加账号 → 扫描二维码
3. 对准二维码，自动识别

**手动输入：**
1. 打开觉照验证器 → 添加账号 → 手动输入
2. 输入服务名称、账号名称、密钥
3. 点击保存

### 查看验证码
打开应用即可看到所有账号的实时验证码，每 30 秒自动刷新。

### 删除账号
在账号卡片上向左滑动，点击删除确认即可。

## 安全特性 | Security Features

| 特性 | 说明 |
|------|------|
| 密钥加密 | HUKS AES-256-GCM，存储在 TEE 可信执行环境 |
| 无网络权限 | 应用不申请任何网络权限 |
| 本地存储 | SQLite 数据库，数据仅存储在本地 |
| 开源代码 | 源代码完全开放，可进行安全审计 |

## 技术架构 | Architecture

```
juezhao_authenticator/
├── entry/src/main/ets/
│   ├── entryability/      # UIAbility 生命周期
│   ├── models/           # 数据模型
│   ├── services/         # 业务服务
│   │   ├── TOTPService.ets    # TOTP 生成
│   │   ├── HUKSService.ets    # 密钥加密
│   │   └── StorageService.ets # 数据库
│   ├── components/       # UI 组件
│   └── pages/           # 页面
└── AppScope/            # 应用配置
```

### 核心技术栈

| 技术 | 版本 | 说明 |
|------|------|------|
| HarmonyOS NEXT | API 12 | 操作系统 |
| ArkTS | - | 开发语言 |
| ArkUI | - | UI 框架 |
| HUKS | - | 密钥管理 |
| relationalStore | - | SQLite 数据库 |
| ScanKit | - | 二维码扫描 |
| cryptoFramework | - | 加密框架 |

## 知识产权 | Intellectual Property

### 专利声明
本项目已申请知识产权保护，详见 [PATENTS.md](PATENTS.md)。

### 商标
"觉照验证器"、"juezhao-authenticator" 及相关标识是Davey Wong的注册商标。

### 开源许可
本项目基于 Apache License 2.0 开源，详见 [LICENSE](LICENSE)。

### 贡献者协议
所有贡献者需同意贡献者许可协议（CLA），详见 [CONTRIBUTING.md](CONTRIBUTING.md)。

## 合规声明 | Compliance

| 合规项目 | 状态 | 说明 |
|----------|------|------|
| 华为应用市场审核 | 待上架 | 符合审核标准 |
| 个人信息保护 | 符合 | 不收集个人信息 |
| 安全检测 | 通过 | 无恶意代码 |
| 开源合规 | 符合 | 所有源码开源 |
| 知识产权 | 受保护 | 专利申请中 |

## 变更日志 | Changelog

详见 [CHANGELOG.md](CHANGELOG.md)

## 贡献指南 | Contributing

详见 [CONTRIBUTING.md](CONTRIBUTING.md)

## 行为准则 | Code of Conduct

详见 [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md)

## 安全政策 | Security Policy

详见 [SECURITY.md](SECURITY.md)

## 许可证 | License

本项目基于 Apache License 2.0 开源，详见 [LICENSE](LICENSE)。

---

## 联系方式 | Contact

- 官网：https://guangweiblog.com
- GitHub：https://github.com/weinotes/juezhao-authenticator-harmonyos
- 邮箱：wgwcko@gmail.com

---

**觉照验证器** - 让认证更安全，让隐私更自主。

*juezhao-authenticator - Secure your digital life.*
