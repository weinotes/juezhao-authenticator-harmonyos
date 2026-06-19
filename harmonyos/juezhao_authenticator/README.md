# 觉照验证器（HarmonyOS NEXT 版）

基于 HarmonyOS NEXT 的离线双因素验证器，完全兼容 RFC 6238 标准的 TOTP 算法。

## 特性

- 离线运行，无需伺服器
- HUKS 硬件级加密存储密钥
- 支持扫码添加账号
- 支持手动输入密钥
- 30 秒自动刷新验证码
- 纯血鸿蒙 ArkTS + ArkUI 开发

## 快速开始

### 本地开发

1. 安装 DevEco Studio
2. 打开 `harmonyos/` 目录
3. 配置签名证书
4. 运行测试

### GitHub Actions 构建

推送 `v*` 标签触发构建：

```bash
git tag v1.0.0-harmonyos
git push origin v1.0.0-harmonyos
```

## 测试用例

- 秘钥：`JBSWY3DPEHPK3PXP`
- 账号：`test@example.com`
- 服务商：`Test`

## 目录结构

```
harmonyos/
└── juezhao_authenticator/   # 鸿蒙项目根目录
    ├── AppScope/
    ├── entry/               # 应用入口模块
    │   └── src/main/ets/
    │       ├── components/  # UI 组件
    │       ├── models/      # 数据模型
    │       ├── pages/       # 页面
    │       ├── services/    # 业务服务
    │       └── utils/       # 工具类
    ├── build-profile.json5
    └── oh-package.json5
```

## 授权

Apache 2.0
