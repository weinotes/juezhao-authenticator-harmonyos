import { Account } from '../models/Account';

@Component
export struct TOTPCodeCard {
  @ObjectLink account: Account;

  build() {
    Row() {
      Column() {
        Text(this.account.issuer)
          .fontSize(14)
          .fontColor('#8E8E93')
          .fontWeight(FontWeight.Medium)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(this.account.name)
          .fontSize(12)
          .fontColor('#8E8E93')
          .margin({ top: 2 })
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Column() {
        Text(this.account.currentCode)
          .fontSize(36)
          .fontWeight(FontWeight.Bold)
          .fontFamily('monospace')
          .letterSpacing(4)
          .fontColor('#000000')

        Row() {
          Progress({
            value: this.account.period - this.account.remainingSeconds,
            total: this.account.period,
            type: ProgressType.Capsule
          })
            .width('70%')
            .height(4)
            .color(this.account.remainingSeconds <= 5 ? '#FF3B30' : '#34C759')

          Text(`${this.account.remainingSeconds}s`)
            .fontSize(12)
            .fontColor(this.account.remainingSeconds <= 5 ? '#FF3B30' : '#8E8E93')
            .margin({ left: 8 })
        }
      }
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#F5F5F7')
    .borderRadius(12)
    .margin({ bottom: 12 })
  }
}
