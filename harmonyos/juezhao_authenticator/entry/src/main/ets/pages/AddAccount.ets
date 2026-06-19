import { Account } from '../models/Account';
import { TOTPService } from '../services/TOTPService';
import { HUKSService } from '../services/HUKSService';
import { StorageService } from '../services/StorageService';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct AddAccount {
  @State name: string = '';
  @State issuer: string = '';
  @State secret: string = '';
  @State digits: number = 6;
  @State period: number = 30;
  @State isSaving: boolean = false;
  @State errorMessage: string = '';

  async aboutToAppear() {
    const params = router.getParams() as Record<string, string | number>;
    if (params) {
      this.name = (params.name as string) || '';
      this.issuer = (params.issuer as string) || '';
      this.secret = (params.secret as string) || '';
      if (params.digits) this.digits = params.digits as number;
      if (params.period) this.period = params.period as number;
    }
  }

  async saveAccount() {
    this.errorMessage = '';
    if (!this.name.trim()) { this.errorMessage = '请输入账号名称'; return; }
    if (!this.secret.trim()) { this.errorMessage = '请输入密钥'; return; }
    if (this.secret.trim().length < 8) { this.errorMessage = '密钥长度不足'; return; }

    try {
      const testCode = await TOTPService.generateTOTP(this.secret.trim(), this.period, this.digits);
      if (!testCode || testCode.length !== this.digits) { this.errorMessage = '密钥格式无效'; return; }
    } catch (e) { this.errorMessage = '密钥格式无效'; return; }

    this.isSaving = true;
    try {
      const encryptedSecret = await HUKSService.encrypt(this.secret.trim());
      const id = Date.now().toString(36) + Math.random().toString(36).substring(2);
      const account = new Account(id, this.name.trim(), this.issuer.trim(), encryptedSecret);
      await StorageService.saveAccount(account);
      router.back();
    } catch (e) {
      this.errorMessage = '保存失败，请重试';
    } finally {
      this.isSaving = false;
    }
  }

  build() {
    Column() {
      Scroll() {
        Column({ space: 16 }) {
          Text('手动添加账号').fontSize(24).fontWeight(FontWeight.Bold).margin({ top: 20, bottom: 8 })

          if (this.errorMessage) {
            Text(this.errorMessage).fontSize(14).fontColor('#FF3B30').width('100%').padding(12).backgroundColor('#FFF0F0').borderRadius(8)
          }

          Column({ space: 8 }) {
            Text('账号名称 *').fontSize(14).fontColor('#8E8E93')
            TextInput({ placeholder: '例如：GitHub' }).width('100%').height(48).fontSize(16).onChange((v: string) => this.name = v)
          }.alignItems(HorizontalAlign.Start).width('90%')

          Column({ space: 8 }) {
            Text('服务提供商').fontSize(14).fontColor('#8E8E93')
            TextInput({ placeholder: '例如：Google' }).width('100%').height(48).fontSize(16).onChange((v: string) => this.issuer = v)
          }.alignItems(HorizontalAlign.Start).width('90%')

          Column({ space: 8 }) {
            Text('密钥 *').fontSize(14).fontColor('#8E8E93')
            TextInput({ placeholder: 'Base32 格式密钥' }).width('100%').height(48).fontSize(16).onChange((v: string) => this.secret = v)
          }.alignItems(HorizontalAlign.Start).width('90%')

          Row() {
            Text('验证码位数').fontSize(14).fontColor('#8E8E93')
            Blank()
            ForEach([6, 8], (d: number) => {
              Button(d.toString()).width(60).height(40).fontSize(16)
                .backgroundColor(this.digits === d ? '#007DFF' : '#E5E5EA')
                .fontColor(this.digits === d ? '#FFFFFF' : '#000000')
                .onClick(() => this.digits = d).margin({ left: 12 })
            })
          }.width('90%')

          Row() {
            Text('刷新周期（秒）').fontSize(14).fontColor('#8E8E93')
            Blank()
            ForEach([30, 60], (p: number) => {
              Button(p.toString()).width(60).height(40).fontSize(16)
                .backgroundColor(this.period === p ? '#007DFF' : '#E5E5EA')
                .fontColor(this.period === p ? '#FFFFFF' : '#000000')
                .onClick(() => this.period = p).margin({ left: 12 })
            })
          }.width('90%')

          Button(this.isSaving ? '保存中...' : '保存账号')
            .width('90%').height(50).fontSize(18).fontColor('#FFFFFF')
            .backgroundColor(this.isSaving ? '#8E8E93' : '#007DFF').borderRadius(25).margin({ top: 20 })
            .enabled(!this.isSaving).onClick(() => this.saveAccount())
        }.width('100%').padding({ bottom: 40 })
      }.width('100%').height('100%')
    }.width('100%').height('100%').backgroundColor('#FFFFFF').padding({ top: 16 })
  }
}
