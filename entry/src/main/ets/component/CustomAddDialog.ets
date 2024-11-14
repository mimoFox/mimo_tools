
@Component
export default struct CustomAddDialog {
  @Link editContent: string
  onClose: () => void = () => {
  }
  onAdd: () => void = () => {
  }

  build() {
    Stack() {
      Rect()
        .width('100%')
        .height('100%')
        .fill('rgba(0,0,0,0.4)')
        .onClick(() => {
          this.onClose()
        })
      Column() {
        TextArea({
          placeholder: '添加笔记内容.',
          text: this.editContent
        })
          .width('100%')
          .height('80%')
          .placeholderFont({ size: 18, weight: 500 })
          .onChange((value: string) => {
            this.editContent = value
          })
      }
      .width('100%')
      .height('50%')
      .backgroundColor('#F0D9B8')
      .borderRadius({ topLeft: 10, topRight: 10 })
      .padding(20)

      // 两个按钮

      Row() {

        Stack() {
          Column().width(60).height(60).borderRadius(30)
            .backgroundColor('#BFA290')
          Image($r('app.media.back')).width(30).height(30)
        }
        .onClick(() => {
          this.onClose()
        })

        // if (this.editContent) {
        //   Stack() {
        //     Column().width(60).height(60).borderRadius(30)
        //       .backgroundColor('#BFA290')
        //     Image($r('app.media.delete')).width(30).height(30)
        //   }
        //   .onClick(() => {
        //     this.onDelete()
        //   })
        // }

        Stack() {
          Column().width(60).height(60).borderRadius(30)
            .backgroundColor('#9E7F6B')
          Image($r('app.media.save')).width(30).height(30)
        }
        .onClick(() => {
          this.onAdd()
        })
      }
      .width('80%')
      .layoutWeight(1)
      .justifyContent(FlexAlign.SpaceBetween)
      .padding(10)
    }
    .width('100%')
    .height('100%')
    .alignContent(Alignment.Bottom)

  }
}

