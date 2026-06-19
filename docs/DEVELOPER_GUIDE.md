# 开发指南 | Developer Guide

## 开发环境 | Development Environment

### 环境要求 | Requirements

| 组件 | 版本 | 说明 |
|------|------|------|
| HarmonyOS SDK | 4.0+ | 操作系统开发包 |
| DevEco Studio | 4.0+ | 官方 IDE |
| Node.js | 18+ | 用于构建工具 |
| ohpm | 5.0+ | 鸿蒙包管理器 |
| JDK | 17+ | Java 运行环境 |

### 安装步骤 | Installation

1. **安装 DevEco Studio**
   - 下载地址：https://developer.huawei.com/consumer/cn/deveco-studio/
   - 安装后配置 SDK 路径

2. **安装 HarmonyOS SDK**
   - 打开 DevEco Studio → Settings → SDK Manager
   - 选择 HarmonyOS NEXT 和 API 12
   - 点击 Install

3. **克隆项目**
   ```bash
   git clone https://github.com/weinotes/juezhao-authenticator-harmonyos.git
   ```

4. **打开项目**
   - 打开 DevEco Studio
   - 选择 Open Project
   - 选择 `harmonyos/juezhao_authenticator` 目录

## 项目结构 | Project Structure

```
juezhao_authenticator/
├── AppScope/                           # 应用全局配置
│   └── resources/base/element/         # 全局字符串资源
│       └── string.json                  # 应用名称等
├── entry/                              # 主模块
│   └── src/main/
│       ├── ets/                        # ArkTS 源码
│       │   ├── entryability/           # UIAbility 生命周期
│       │   │   └── EntryAbility.ets
│       │   ├── models/                 # 数据模型
│       │   │   └── Account.ets
│       │   ├── services/               # 业务服务层
│       │   │   ├── TOTPService.ets     # TOTP 算法实现
│       │   │   ├── HUKSService.ets    # 密钥加密服务
│       │   │   └── StorageService.ets  # 数据库服务
│       │   ├── components/            # UI 组件
│       │   │   └── TOTPCodeCard.ets   # 验证码卡片
│       │   ├── pages/                 # 页面
│       │   │   ├── Index.ets          # 首页
│       │   │   ├── AddAccount.ets     # 添加账号
│       │   │   └── ScanCode.ets       # 扫码页
│       │   └── utils/                 # 工具类
│       │       ├── Base32Util.ets      # Base32 编解码
│       │       └── TimeUtil.ets       # 时间工具
│       ├── module.json5                # 模块配置
│       └── resources/                  # 资源文件
│           └── base/
│               ├── element/            # 字符串、颜色
│               └── profile/            # 页面配置
├── build-profile.json5                 # 构建配置
├── hvigorfile.ts                       # Hvigor 构建脚本
└── oh-package.json5                    # 依赖配置
```

## 核心模块 | Core Modules

### 1. TOTPService - TOTP 算法实现

```typescript
// 核心功能
generateTOTP(secret: string, period: number, digits: number): Promise<string>

// 算法流程
1. Base32 解码密钥
2. 获取当前时间戳
3. 计算计数器值 T = floor(timestamp / period)
4. 将计数器转为 8 字节大端序
5. HMAC-SHA1 签名
6. 动态截断获取 6 位数字
```

### 2. HUKSService - 密钥加密

```typescript
// 核心功能
generateKey(): Promise<void>     // 生成 AES-256 密钥
encrypt(plainText: string): Promise<string>  // AES-256-GCM 加密
decrypt(cipherText: string): Promise<string>  // AES-256-GCM 解密
```

### 3. StorageService - 数据存储

```typescript
// 核心功能
init(context: Context): Promise<void>           // 初始化数据库
saveAccount(account: Account): Promise<void>    // 保存账号
loadAccounts(): Promise<Account[]>              // 加载账号
deleteAccount(id: string): Promise<void>        // 删除账号
```

## 代码规范 | Code Standards

### ArkTS 编码规范

1. **命名规范**
   - 类名：`UpperCamelCase`（如 `TOTPService`）
   - 方法名：`lowerCamelCase`（如 `generateTOTP`）
   - 常量：`UPPER_SNAKE_CASE`（如 `AES_KEY_ALIAS`）
   - 文件名：`lower_snake_case.ets`（如 `totp_service.ets`）

2. **类型声明**
   - 优先使用显式类型
   - 避免使用 `any`
   - 使用 `@Observed` 进行响应式更新

3. **组件规范**
   - UI 组件使用 `@Component` 装饰
   - 页面使用 `@Entry` 装饰
   - 状态变量使用 `@State` 装饰

### Git 提交规范

遵循 Conventional Commits：

```
<type>(<scope>): <description>

feat(services): add TOTP generation
fix(components): fix countdown display
docs(readme): update installation guide
```

## 构建与发布 | Build and Release

### 本地构建

```bash
# 安装依赖
ohpm install

# Debug 构建
hvigor assembleDebug

# Release 构建
hvigor assembleRelease
```

### GitHub Actions 自动构建

推送代码到 `harmonyos/` 目录或打标签（`v*`）自动触发构建。

### 发布流程

1. 更新版本号（`AppScope/app.json5`）
2. 更新 CHANGELOG.md
3. 创建 Git Tag
4. GitHub Actions 自动构建 HAP
5. 下载 HAP 进行测试
6. 发布到应用市场

## 测试 | Testing

### 单元测试

使用 Hypium 测试框架：

```typescript
import hilog from '@ohos.hilog';

@Suite
class TOTPServiceTest {
  @Test
  'test generateTOTP'() {
    const secret = 'JBSWY3DPEHPK3PXP';
    const result = TOTPService.generateTOTP(secret, 30, 6);
    expect(result.length).assertEqual(6);
  }
}
```

### 测试用例

RFC 6238 标准测试向量：

| 密钥 | 时间步长 | 结果 |
|------|----------|------|
| JBSWY3DPEHPK3PXP | 30 | 6位数字 |

## 调试 | Debugging

### DevEco Studio 调试

1. 连接设备或启动模拟器
2. 点击 Debug 按钮
3. 设置断点
4. 查看变量值

### 日志输出

```typescript
import hilog from '@ohos.hilog';

hilog.info(0x0000, 'TOTPService', 'Generated TOTP: %{public}s', code);
```

## 常见问题 | FAQ

**Q: HAP 无法安装？**
A: 确保设备是 HarmonyOS NEXT 系统，旧版鸿蒙不兼容。

**Q: 验证码不正确？**
A: 检查手机时间是否准确，TOTP 依赖精确时间。

**Q: 如何调试 HUKS？**
A: 使用 `hilog` 输出加密中间结果，检查返回值。

---

*本开发指南最后更新：2024年*
