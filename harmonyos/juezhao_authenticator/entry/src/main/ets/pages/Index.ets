import { Account } from '../models/Account';
import { TOTPService } from '../services/TOTPService';
import { HUKSService } from '../services/HUKSService';
import { StorageService } from '../services/StorageService';
import { TimeUtil } from '../utils/TimeUtil';
import { TOTPCodeCard } from '../components/TOTPCodeCard';
import { router } from '@kit.ArkUI';

interface AccountState extends Account {
  secret: string;
}

@Entry
@Component
struct Index {
  @State accounts: AccountState[] = [];
  private timer: number = -1;

  async aboutToAppear() {
    await HUKSService.generateKey();
    await StorageService.init(this.getContext());

    const savedAccounts = await StorageService.loadAccounts();
    this.accounts = [];
    for (const account of savedAccounts) {
      try {
        const secret = await HUKSService.decrypt(account.encryptedSecret);
        const code = await TOTPService.generateTOTP(secret, account.period, account.digits);
        const state: AccountState = { ...account, secret, currentCode: code };
        state.remainingSeconds = TimeUtil.getRemainingSeconds(account.period);
        this.accounts.push(state);
      } catch (e) {
        console.error(`Failed to decrypt account: ${account.name}`);
      }
    }

    this.timer = setInterval(() => this.refreshCodes(), 1000);
  }

  aboutToDisappear() {
    if (this.timer !== -1) clearInterval(this.timer);
  }

  async refreshCodes() {
    for (const account of this.accounts) {
      account.remainingSeconds = TimeUtil.getRemainingSeconds(account.period);
      if (account.remainingSeconds === account.period) {
        try {
          account.currentCode = await TOTPService.generateTOTP(account.secret, account.period, account.digits);
        } catch (e) {
          console.error(`Failed to refresh code: ${account.name}`);
        }
      }
    }
  }

  async confirmDelete(account: AccountState) {
    try {
      await StorageService.deleteAccount(account.id);
      const index = this.accounts.indexOf(account);
      if (index >= 0) this.accounts.splice(index, 1);
    } catch (e) {
      console.error(`Failed to delete account: ${account.name}`);
    }
  }

  build() {
    Navigation() {
      Column() {
        if (this.accounts.length === 0) {
          Column() {
            Text('还没有添加任何账号')
              .fontSize(16)
              .fontColor('#8E8E93')
              .margin({ top: 40 })
            Text('点击下方按钮扫描二维码或手动输入')
              .fontSize(14)
              .fontColor('#8E8E93')
              .margin({ top: 8 })
          }
          .width('100%')
          .height('40%')
          .justifyContent(FlexAlign.Center)
        } else {
          List({ space: 0 }) {
            ForEach(this.accounts, (account: AccountState) => {
              ListItem() {
                Row() {
                  TOTPCodeCard({ account: account })
                    .layoutWeight(1)
                  Text('删除')
                    .fontSize(14)
                    .fontColor('#FF3B30')
                    .margin({ right: 16 })
                    .onClick(() => {
                      AlertDialog.show({
                        title: '确认删除',
                        message: `确定要删除 ${account.name} 吗？`,
                        primaryButton: { value: '取消', action: () => {} },
                        secondaryButton: { value: '删除', action: () => this.confirmDelete(account) }
                      });
                    })
                }
              }
            }, (account: AccountState) => account.id)
          }
          .layoutWeight(1)
          .padding({ left: 16, right: 16 })
        }

        Button('添加账号')
          .width('90%')
          .height(50)
          .fontSize(18)
          .fontColor('#FFFFFF')
          .backgroundColor('#007DFF')
          .borderRadius(25)
          .margin({ bottom: 40 })
          .onClick(() => {
            router.pushUrl({ url: 'pages/ScanCode' });
          })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#FFFFFF')
    }
    .title('觉照验证器')
    .titleMode(NavigationTitleMode.InLine)
  }
}
