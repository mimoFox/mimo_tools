import { router } from '@kit.ArkUI'

@Component
export default struct CustomTitle {
  @Link order: boolean
  @Link isAddDialog: boolean

  @Styles
  titleButtonStyle(){
    .width(58)
    .height(36)
    .borderColor('#ffa96545')
    .borderWidth(1)
    .borderRadius(4)
  }

  build() {
    // 导航栏
    Row() {

      Button() {
        Image($r('app.media.ic_back'))
          .width(24).height(24)
      }
      .type(ButtonType.Normal)
      .borderRadius(10)
      .backgroundColor(Color.Transparent)
      .fontColor(Color.Black)
      .fontSize(30)
      .onClick(() => {
        router.back({ url: 'pages/Index' });
      })

      Blank()

      // 标题
      Text('Mimo Note')
        .fontSize(25)
        .fontWeight(700)
        .fontColor($r('sys.color.white'))

      Blank()
      // 排序按钮
      Column() {
        if (this.order) {
          Image($r('app.media.up')).width(24).height(24)
        } else {
          Image($r('app.media.down')).width(24).height(24)
        }

      }
      //.titleButtonStyle()
      .justifyContent(FlexAlign.Center)
      .onClick(() => {
        this.order = !this.order
      })

      // 编辑按钮
      Column() {
        Image($r('app.media.edit')).width(24).height(24)
      }
      //.titleButtonStyle()
      .justifyContent(FlexAlign.Center)
      .onClick(() => {
        this.isAddDialog = true
      })
      .margin({ left: 10 })
    }
    .width('100%')
    .height(60)
    .padding({ left: 10, right: 10 })
    .linearGradient({
      direction: GradientDirection.Bottom,
      colors: [['#7B6558', 0.5], ['#725A4E', 1]]
    })
    .shadow({
      radius: 10,
      color: 'rgba(0,0,0,0.3)',
      offsetX: 0,
      offsetY: 10
    })
  }
}