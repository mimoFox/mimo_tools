@Component
export default struct LightCard {
  @Link sColor: string
  @Prop rgbaList: string[]
  @Link red: number
  @Link green: number
  @Link blue: number
  @Link s_opacity: number
  @Link b_opacity: number
  @State hexRed: string = ''
  @State hexGreen: string = ''
  @State hexBlue: string = ''
  @State hexString: string = ''

  rgbToHex(red: number, green: number, blue: number) {
    // 转换为十六进制表示
    this.hexRed = red.toString(16).padStart(2, '0').toUpperCase();
    this.hexGreen = green.toString(16).padStart(2, '0').toUpperCase();
    this.hexBlue = blue.toString(16).padStart(2, '0').toUpperCase();

    // 拼接颜色通道的十六进制表示
    this.hexString = this.hexRed + this.hexGreen + this.hexBlue;
    return this.hexString;
  }

  build() {
    Column() {
      // 热门颜色
      Row({ space: 5 }) {
        ForEach(this.rgbaList, (item: string, index) => {
          Text('')
            .layoutWeight(1)
            .height('100%')
            .backgroundColor(item)
            .stateStyles({
              pressed: {
                .border({
                  width: 1,
                  color: Color.Orange
                })
              },
              normal: {
                .border({
                  width: 1,
                  color: Color.White
                })
              }
            })
            .onClick(() => {
              this.sColor = this.rgbaList[index]
              const rgbValues = this.rgbaList[index].replace(/^(rgb|rgba)\(/, '').replace(/\)$/, '').split(',')
              this.red = parseInt(rgbValues[0].trim());
              this.green = parseInt(rgbValues[1].trim());
              this.blue = parseInt(rgbValues[2].trim());
            })

        })
      }
      .height(60)
      .margin({ top: 10 })

      // 饱和度、明亮度
      Column() {
        Row() {
          Image($r('app.media.Saturation')).width(24).height(24)
          Slider({
            style: SliderStyle.OutSet,
            value: this.s_opacity,
            step: 0.01,
            min: 0,
            max: 1
          })
            .blockSize({ width: 20, height: 20 })
            .blockBorderColor(Color.White)
            .blockBorderWidth(5)
            .layoutWeight(1)
            .blockColor('#ebfcc6c6')
            .onChange((value) => {
              this.s_opacity = value
            })
          Image($r('app.media.Saturation')).width(24).height(24)
            .fillColor('#fbc6c6')
        }

        Row() {
          Image($r('app.media.Brightness')).width(24).height(24)
            .fillColor('#fffdfaca')
          Slider({
            style: SliderStyle.OutSet,
            value: this.b_opacity,
            step: 0.01,
            min: 0,
            max: 1
          })
            .blockSize({ width: 20, height: 20 })
            .blockBorderColor(Color.White)
            .blockBorderWidth(5)
            .layoutWeight(1)
            .blockColor('#fcc6c6')
            .onChange((value) => {
              this.b_opacity = value
            })
          Image($r('app.media.Brightness')).width(24).height(24)
            .fillColor('#fff7ff00')
        }
      }
      .width('100%')
      .margin({ top: 20 })

      // 颜色显示区
      Column() {

      }
      .width(100)
      .height(100)
      .borderRadius(50)
      .margin({ top: 15 })
      .saturate(this.s_opacity)
      .brightness(this.b_opacity)
      .backgroundColor(`rgba(${this.red},${this.green},${this.blue},${this.b_opacity})`)

      // 调色区
      Row({ space: 10 }) {
        Column({ space: 5 }) {
          Text('R').fontSize(18).fontWeight(500)
          TextInput({ text: this.red.toString() })
            .type(InputType.Number)
            .borderRadius(0)
            .onChange((value: string) => {
              this.red = Number(value)
            })
          Slider({
            style: SliderStyle.OutSet,
            value: this.red,
            min: 0,
            max: 255
          })
            .blockSize({ width: 20, height: 20 })
            .blockBorderColor(Color.White)
            .blockBorderWidth(5)
            .layoutWeight(1)
            .blockColor('#ebfcc6c6')
            .onChange((value) => {
              this.red = value
            })
        }
        .height('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Start)

        Column({ space: 5 }) {
          Text('G').fontSize(18).fontWeight(500)
          TextInput({ text: this.green.toString() })
            .borderRadius(0).type(InputType.Number)
            .onChange((value: string) => {
              this.green = Number(value)
            })

          Slider({
            style: SliderStyle.OutSet,
            value: this.green,
            min: 0,
            max: 255
          })
            .blockSize({ width: 20, height: 20 })
            .blockBorderColor(Color.White)
            .blockBorderWidth(5)
            .layoutWeight(1)
            .blockColor('#ebfcc6c6')
            .onChange((value) => {
              this.green = value
            })
        }
        .height('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Start)

        Column({ space: 5 }) {
          Text('B').fontSize(18).fontWeight(500)
          TextInput({ text: this.blue.toString() })
            .type(InputType.Number).borderRadius(0)
            .onChange((value: string) => {
              this.blue = Number(value)
            })

          Slider({
            style: SliderStyle.OutSet,
            value: this.blue,
            min: 0,
            max: 255
          })
            .blockSize({ width: 20, height: 20 })
            .blockBorderColor(Color.White)
            .blockBorderWidth(5)
            .layoutWeight(1)
            .blockColor('#ebfcc6c6')
            .onChange((value) => {
              this.blue = value
            })
        }
        .height('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Start)

        Column({ space: 5 }) {
          Text('十六进制').fontSize(18).fontWeight(500)
          Text('#' + this.rgbToHex(this.red, this.green, this.blue))
            .borderRadius(0).fontSize(16)
        }
        .height('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.SpaceAround)
      }
      .width('100%')
      .height(80)
      .alignItems(VerticalAlign.Center)
      .margin({ top: 15 })
    }
    .width('100%')
    .height('100%')
    .padding({ left: 10, right: 10 })
    .borderRadius({ topLeft: 10, topRight: 10 })
  }
}