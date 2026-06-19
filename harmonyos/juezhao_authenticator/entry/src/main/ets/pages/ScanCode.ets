import scanBarcode from '@ohos.scanBarcode';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct ScanCode {
  @State scanError: string = '';

  build() {
    Column() {
      Scroll() {
        Column({ space: 20 }) {
          Text('添加账号').fontSize(24).fontWeight(FontWeight.Bold).margin({ top: 20 })
          Text('选择添加方式').fontSize(16).fontColor('#8E8E93').margin({ top: 8 })

          Button('扫描二维码')
            .width('90%').height(55).fontSize(18).fontColor('#FFFFFF')
            .backgroundColor('#007DFF').borderRadius(12)
            .onClick(() => this.startScan())

          if (this.scanError) {
            Text(this.scanError).fontSize(14).fontColor('#FF3B30').width('90%').textAlign(TextAlign.Center)
          }

          Divider().width('90%').color('#E5E5EA').margin({ top: 20 })
          Text('或者').fontSize(14).fontColor('#8E8E93')

          Button('手动输入')
            .width('90%').height(55).fontSize(18).fontColor('#007DFF')
            .backgroundColor('#FFFFFF').borderRadius(12).borderWidth(1).borderColor('#007DFF')
            .onClick(() => router.pushUrl({ url: 'pages/AddAccount' }))
        }.width('100%').padding({ bottom: 40 })
      }.width('100%').height('100%')
    }.width('100%').height('100%').backgroundColor('#FFFFFF')
  }

  async startScan() {
    this.scanError = '';
    try {
      const options: scanBarcode.ScanOptions = {
        scanTypes: [scanBarcode.ScanType.QR_CODE],
        enableMultiMode: false,
        enableAlbum: true
      };

      const result = await scanBarcode.startScanForResult(this.getContext(), options);
      if (result.originalValue?.startsWith('otpauth://')) {
        this.parseOtpUri(result.originalValue);
      } else {
        this.scanError = '未识别到有效的验证器二维码';
      }
    } catch (error) {
      this.scanError = '扫描失败，请重试';
    }
  }

  parseOtpUri(uri: string) {
    try {
      const url = new URL(uri);
      const pathParts = url.pathname.substring(1).split(':');
      const name = pathParts.length > 1 ? decodeURIComponent(pathParts[1]) : decodeURIComponent(pathParts[0]);
      const issuer = url.searchParams.get('issuer') || (pathParts.length > 1 ? decodeURIComponent(pathParts[0]) : '');
      const secret = url.searchParams.get('secret');
      const digits = parseInt(url.searchParams.get('digits') || '6');
      const period = parseInt(url.searchParams.get('period') || '30');

      if (!secret) { this.scanError = '二维码中缺少密钥信息'; return; }

      router.pushUrl({ url: 'pages/AddAccount', params: { name, issuer, secret, digits, period } });
    } catch (error) {
      this.scanError = '解析二维码失败';
    }
  }
}
