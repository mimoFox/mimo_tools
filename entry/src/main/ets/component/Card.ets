import { router } from '@kit.ArkUI'

@Preview
@Component
export default struct Card {
  title: string = ''
  img: ResourceStr = ''
  bgColor_one: string = ''
  bgColor_two: string = ''
  fillColor: string = ''
  url: string = ''
  rToNext: () => void = () => {
    router.pushUrl({
      url: this.url
    })
  }

  build() {
    Column({ space: 10 }) {
      Image(this.img)
        .width(50)
        .height(50)
        .fillColor(this.fillColor)
      Text(this.title)
        .fontSize(20)
        .fontColor(Color.White)
        .fontWeight(500)
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .borderRadius(10)
    .linearGradient({
      // 0点方向顺时针旋转为正向角度，线性渐变起始角度的默认值为180°
      colors: [
        [this.bgColor_one, 0.1], // 颜色断点1的颜色和比重，对应组件在180°方向上的起始位置
        [this.bgColor_two, 1.0],// 颜色断点2的颜色和比重，对应组件在180°方向上的终点位置
      ],
      angle: 120,
    })
    .onClick(() => {
      this.rToNext()
    })
  }
}