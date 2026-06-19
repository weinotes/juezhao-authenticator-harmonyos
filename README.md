# 觉照验证器 (juezhao-authenticator)

<p align="center">
  <img src="docs/images/icon.svg" width="120" alt="觉照验证器 Logo" />
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
  <a href="https://gitee.com/juezhao/juezhao-authenticator-harmonyos">
    <img src="https://img.shields.io/badge/镜像-Gitee-FF502C" alt="Gitee" />
  </a>
</p>

---

## 特性

- 🔒 **离线运行** - 无需服务器，无需网络，密钥永不离开设备
- 🛡️ **硬件级加密** - 使用鸿蒙 HUKS 通用密钥体系，AES-256-GCM 加密
- 📱 **原生性能** - 纯血鸿蒙 ArkTS + ArkUI 开发，充分利用系统能力
- 📷 **扫码添加** - 支持 ScanKit 扫码解析 otpauth:// 协议
- ⏱️ **实时刷新** - 30 秒自动刷新，精准倒计时
- 💾 **本地存储** - SQLite 数据库，所有数据仅存储在本地

## 兼容说明

本应用完全兼容 Google Authenticator、Microsoft Authenticator 等主流验证器使用的 **RFC 6238** TOTP 标准。

支持的算法：
- HMAC-SHA1（默认）
- HMAC-SHA256（可选）
- HMAC-SHA512（可选）

支持的参数：
- 验证码位数：6 位或 8 位
- 时间步长：30 秒或 60 秒

## 安全说明

1. **密钥加密存储**：使用设备 TEE（可信执行环境）生成的密钥进行 AES-256-GCM 加密
2. **无网络权限**：应用不申请任何网络权限，完全离线运行
3. **不收集数据**：不收集任何用户数据，不包含任何埋点或分析
4. **开源可审计**：源代码完全开放，欢迎安全审计

## 安装

### 方式一：直接下载

从 [Releases](https://github.com/weinotes/juezhao-authenticator-harmonyos/releases) 页面下载最新的 `.hap` 文件：

```bash
# 使用 hdc 安装
hdc install juezhao_authenticator_entry-release-signed.hap
```

### 方式二：应用市场

即将上架华为应用市场，届时可直接在应用商店搜索安装。

### 方式三：自行编译

```bash
# 1. 克隆仓库
git clone https://github.com/weinotes/juezhao-authenticator-harmonyos.git
cd juezhao-authenticator-harmonyos

# 2. 安装依赖
ohpm install

# 3. 构建
hvigor assembleRelease

# 4. 安装
hdc install entry/build/default/output/default/release/juezhao_authenticator_entry-release-signed.hap
```

## 使用方法

### 添加账号

**方式一：扫码添加**
1. 打开其他支持 TOTP 的应用（如 Google Authenticator），获取二维码
2. 打开觉照验证器，点击「添加账号」
3. 选择「扫描二维码」，对准二维码
4. 确认信息后保存

**方式二：手动输入**
1. 在目标网站的二次验证设置页面，找到「手动输入密钥」选项
2. 复制显示的密钥
3. 打开觉照验证器，点击「添加账号」
4. 选择「手动输入」，填入账号名称和密钥
5. 保存

### 查看验证码

打开应用后，所有已添加的账号会实时显示验证码，每 30 秒自动刷新。

### 删除账号

在账号卡片上向左滑动，或点击「删除」按钮，确认后即可删除。

## 技术架构

```
juezhao_authenticator/
├── entry/                           # 应用入口模块
│   └── src/main/ets/
│       ├── entryability/            # UIAbility 生命周期
│       ├── models/                  # 数据模型
│       │   └── Account.ets         # 账号数据模型
│       ├── services/                # 业务服务层
│       │   ├── TOTPService.ets      # TOTP 生成服务
│       │   ├── HUKSService.ets      # 密钥加密服务
│       │   └── StorageService.ets   # 数据库服务
│       ├── components/              # UI 组件
│       │   └── TOTPCodeCard.ets     # 验证码卡片组件
│       ├── pages/                   # 页面
│       │   ├── Index.ets            # 首页（账号列表）
│       │   ├── AddAccount.ets       # 添加账号页
│       │   └── ScanCode.ets         # 扫码页
│       └── utils/                   # 工具类
│           ├── Base32Util.ets        # Base32 编解码
│           └── TimeUtil.ets          # 时间工具
├── AppScope/                        # 应用全局配置
│   └── resources/                   # 全局资源
└── build-profile.json5              # 构建配置
```

### 核心技术

| 技术 | 说明 |
|------|------|
| HarmonyOS NEXT API 12 | 操作系统版本 |
| ArkTS | 开发语言 |
| ArkUI | UI 框架 |
| HUKS | 鸿蒙通用密钥体系（AES-256-GCM） |
| relationalStore | SQLite 本地数据库 |
| ScanKit | 二维码扫描能力 |
| cryptoFramework | 密码学框架（HMAC-SHA1） |

## 项目结构

```
juezhao-authenticator-harmonyos/
├── harmonyos/                      # 鸿蒙项目源码
│   └── juezhao_authenticator/
│       ├── entry/                  # 应用模块
│       ├── AppScope/               # 应用配置
│       ├── build-profile.json5     # 构建配置
│       └── oh-package.json5        # 依赖配置
├── .github/                         # GitHub 配置
│   └── workflows/                  # CI/CD 工作流
├── docs/                           # 文档
│   ├── images/                     # 图片资源
│   ├── README.md                   # 项目说明
│   ├── INSTALL.md                  # 安装指南
│   ├── USAGE.md                    # 使用教程
│   ├── ARCHITECTURE.md             # 架构设计
│   ├── API.md                      # API 文档
│   ├── SECURITY.md                 # 安全说明
│   ├── CONTRIBUTING.md             # 贡献指南
│   ├── CHANGELOG.md                # 变更日志
│   └── LICENSE                     # 许可证
└── README.md                       # 本文件
```

## 测试用例

使用以下测试密钥验证应用功能：

| 字段 | 值 |
|------|-----|
| 服务商 | Test |
| 账号 | test@example.com |
| 密钥 | `JBSWY3DPEHPK3PXP` |

> ⚠️ 此密钥为 RFC 6238 标准测试密钥，仅用于开发测试，请勿用于生产环境。

生成结果应为 6 位数字，每 30 秒更新一次。

## 路线图

- [x] 基础 TOTP 生成
- [x] 二维码扫描添加
- [x] 手动输入添加
- [x] 账号删除
- [x] 本地加密存储
- [ ] 生物识别锁定（指纹/面容）
- [ ] 备份与导出
- [ ] 账号排序与分类
- [ ] 多语言支持
- [ ] 深色模式
- [ ] 华为应用市场上架

## 参与贡献

欢迎提交 Issue 和 Pull Request！

请阅读 [CONTRIBUTING.md](docs/CONTRIBUTING.md) 了解贡献指南。

## 开源许可

本项目基于 [Apache-2.0](LICENSE) 许可证开源。

## 联系方式

- 官网：https://www.juezhaotrade.com
- GitHub Issues：https://github.com/weinotes/juezhao-authenticator-harmonyos/issues
- 邮箱：contact@juezhaotrade.com

---

**觉照验证器** - 让认证更安全，让隐私更自主。
