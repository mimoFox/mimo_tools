import LightCard from '../../component/LightCard';

@Entry
@Component
struct FillLight {
  @State message: string = 'Hello World';
  /*
   * 热门的补光颜色RGB数值如下‌：
      ‌银河白‌：#FFFFFF，RGB(255,255,255)
      ‌杏仁黄‌：#FAF9DE，RGB(250,249,222)
      ‌秋叶褐‌：#FFF2E2，RGB(255,242,226)
      ‌胭脂红‌：#FDE6E0，RGB(253,230,224)
      ‌青草绿‌：#E3EDCD，RGB(227,237,205)
      ‌海天蓝‌：#DCE2F1，RGB(220,226,241)
      ‌葛巾紫‌：#E9EBFE，RGB(233,235,254)
      ‌极光灰‌：#EAEAEF，RGB(234,234,239)
* */
  @State rgbaList: string[] = [
    'rgba(250,249,222, 1.00)',
    'rgba(255,242,226, 1.00)',
    'rgba(253,230,224, 1.00)',
    'rgba(227,237,205, 1.00)',

  ]
  @State isShow: boolean = false
  public valueArr: number[] = [10, 10, 10, 10, 10, 10, 10, 10, 10]
  @State @Watch('onColorChange') red: number = 0
  @State @Watch('onColorChange') green: number = 0
  @State @Watch('onColorChange') blue: number = 0
  @State s_opacity: number = 1
  @State b_opacity: number = 1
  @State sColor: string = 'rgba(253,230,224, 1.00)'
  @State cColor: string = `rgba(${this.red},${this.green},${this.blue},${this.b_opacity})`

  onColorChange() {
    return this.sColor = `rgba(${this.red},${this.green},${this.blue},${this.b_opacity})`
  }

  @Builder
  myBuilder() {
    Row() {
      LightCard({
        sColor: $sColor,
        rgbaList: this.rgbaList,
        red: $red,
        green: $green,
        blue: $blue,
        s_opacity: $s_opacity,
        b_opacity: $b_opacity
      })
    }
    .width('100%')
    .padding(5)
  }

  build() {
    Column() {

      Stack() {
        if (this.isShow) {
          Rect()
            .width('100%')
            .height('100%')
            .fill('rgba(0,0,0,0.01)')
            .onClick(() => {
              this.isShow = false
            })
        }
        Row() {
          Button() {
            Image($r("app.media.glass_color")).width(60).height(60)
          }
          .type(ButtonType.Circle)
          .backgroundColor(Color.Transparent)
          .onClick(() => {
            this.isShow = true
          })
          .bindSheet($$this.isShow, this.myBuilder(), {
            detents: [SheetSize.MEDIUM, SheetSize.LARGE, 200],
            backgroundColor: Color.White,
            showClose: false, //不显示关闭按钮
            enableOutsideInteractive: true, //允许交互，不显示蒙层
            blurStyle: BlurStyle.Thick,
            preferType: SheetType.CENTER,
            shouldDismiss: ((sheetDismiss: SheetDismiss) => {
              console.log("bind sheet shouldDismiss")
              sheetDismiss.dismiss()
            })
          })
        }
        .width('100%')
        .padding({ left: 20 })
      }

    }
    .height('100%')
    .width('100%')
    .justifyContent(FlexAlign.End)
    .backgroundColor(this.sColor)
    .saturate(this.s_opacity)
    .brightness(this.b_opacity)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])

  }
}