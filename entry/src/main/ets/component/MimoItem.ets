import MimoModel from '../model/MimoModel'

interface TimeFormat {
  range: string
  formatDate: string
  formatTime: string
}

function getFormatTime(timeStamp: number): TimeFormat {
  const today = new Date();
  const date = new Date(timeStamp);

  // 计算日期差值
  const diffTime = today.getTime() - date.getTime();
  // 向下取整
  const diffDays = Math.floor(diffTime / (24 * 60 * 60 * 1000));

  let range: string = ''

  if (diffDays === 0) {
    range = '今天'
  } else if (diffDays === 1) {
    range = '昨天'
  } else if (diffDays === 2) {
    range = '前天'
  } else {
    range = '三天前'
  }

  const month: string = (date.getMonth() + 1).toString().padStart(2, '0')
  const day: string = date.getDate().toString().padStart(2, '0')
  const hours: string = date.getHours().toString().padStart(2, '0')
  const minute: string = date.getMinutes().toString().padStart(2, '0')

  const formatDate: string = `${month}月${day}日`
  const formatTime: string = `${hours}:${minute}`

  return { range, formatDate, formatTime }

}

@Component
export default struct MimoItem {
  @ObjectLink mimo: MimoModel
  onMimoClick: (mimo: MimoModel) => void = () => {
  }

  build() {
    Row() {
      Stack() {
        Row() {
          Column() {

          }
          .width(26)
          .height('100%')
          .linearGradient({
            direction: GradientDirection.Bottom,
            colors: [['#F5F5ED', 0.5], ['#EEE4DB', 1]]
          })

          // 分割线
          Divider().vertical(true).height('100%').color('#EEE4DB')
          // 右侧
          Column({ space: 5 }) {
            // 创建日期
            Row({ space: 10 }) {
              Text(getFormatTime(this.mimo.updateTime).range)
                .fontSize(12).fontColor('#BFA290')
              Text(getFormatTime(this.mimo.updateTime).formatDate)
                .fontSize(12).fontColor('#BFA290')
              Text(getFormatTime(this.mimo.updateTime).formatTime)
                .fontSize(12).fontColor('#BFA290')
            }
            .margin({ left: 10 })
            .height(25)

            Divider().color('#EEE4DB')

            // 笔记内容
            Column() {
              Text(this.mimo.content)
                .fontColor('#604637')
                .maxLines(2)
                .margin({ right: 10 })
            }
            .margin({ left: 10 })
            .justifyContent(FlexAlign.Start)
            .height(64)

          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)
          .linearGradient({
            direction: GradientDirection.Bottom,
            colors: [['#FBFDF7', 0.5], ['#F1EDE2', 1]]
          })
          .height('100%')
          .borderRadius({ topRight: 4, bottomRight: 4 })

        }
        .shadow({
          radius: 10,
          color: "rgba(0,0,0,0.1)",
          offsetY: 4
        })

        // 回形针
        Image($r('app.media.clip'))
          .height(30)
          .offset({ x: -33 })
      }
      .width('100%')
      .alignContent(Alignment.Start)

    }
    .width('100%')
    .height(90)
    .margin({ top: 12 })
    .padding({ left: 20, right: 20 })
    .onClick(() => {
      this.onMimoClick(this.mimo)
    })

  }
}