import Card from '../component/Card';

@Entry
@Component
struct Index {
  @State timeText: string = ''

  getTimeOfDay() {
    let now = new Date();
    let hour = now.getHours();
    if (hour < 12) {
      return this.timeText = '上午好 !'
    } else if (hour < 18) {
      return this.timeText = '下午好 !'
    } else if (hour < 22) {
      return this.timeText = '晚上好 !'
    } else {
      return this.timeText = '夜深了 !'
    }
  }

  aboutToAppear(): void {
    this.getTimeOfDay()
  }

  build() {
    Column() {
      // 头部
      Row() {
        Image($r('app.media.avatar'))
          .width(50)
          .height(50)
          .borderRadius(25)
          .objectFit(ImageFit.Contain)
          .fillColor('#ff4fbcf8')

        Column({ space: 6 }) {
          Text(this.timeText)
            .fontSize(20)
            .fontWeight(600)
          Text('一个人跑步时,风会拥抱你。😊')
            .fontSize(16)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.Center)
        .padding({ left: 10 })
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)
      .justifyContent(FlexAlign.Start)
      .margin({ top: 10, bottom: 20 })

      // 功能区
      Grid() {
        GridItem() {
          Card({
            img: $r('app.media.book_pages_fill_1'),
            title: '英语学习',
            bgColor_one: '#fffababa',
            bgColor_two: '#fffc8484',
            fillColor: '#ffff7700',
            url: 'pages/courses/CourseIndex'
          })
        }

        GridItem() {
          Card({
            img: $r('app.media.doc_plaintext_and_pencil_fill'),
            title: '笔记',
            bgColor_one: '#fff6b68b',
            bgColor_two: '#fffc8637',
            fillColor: '#ffff4800',
            url: 'pages/notebook/NoteBook'
          })
        }

        GridItem() {
          Card({
            img: $r('app.media.lights'),
            title: '补光灯',
            bgColor_one: '#fffc89e3',
            bgColor_two: '#fffc52d7',
            fillColor: '#ffffd300',
            url: 'pages/light/FillLight'
          })
        }

        GridItem() {
          Card({
            img: $r('app.media.lights'),
            title: '音乐',
            bgColor_one: '#fffc89e3',
            bgColor_two: '#fffc52d7',
            fillColor: '#ffffd300',
            url: 'pages/light/FillLight'
          })
        }

      }
      .columnsTemplate('1fr 1fr 1fr')
      .rowsTemplate('1fr 1fr 1fr 1fr 1fr 1fr')
      .rowsGap(10)
      .columnsGap(10)
    }
    .width('100%')
    .height('100%')
    .padding({ left: 10, right: 10, top: 10 })
    .backgroundColor('#fffaf7ed')

  }
}