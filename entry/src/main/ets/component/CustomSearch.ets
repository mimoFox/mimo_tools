@Component
export default struct CustomSearch {
  @Link keyWord: string
  cleanKeywords: () => void = () => {
  }

  build() {
    Row() {
      Row() {
        Image($r('app.media.search'))
          .width(16)
          .margin({ left: 10 })

        TextInput({ placeholder: '搜索内容', text: this.keyWord })
          .backgroundColor('#FFFFFF')
          .onChange((value: string) => {
            this.keyWord = value
          })
        if (this.keyWord) {
          Column() {
            Image($r('app.media.cancel'))
              .width(16)
              .margin({ right: 10 })
          }
          .width(18)
          .height(18)
          .onClick(() => {
            this.cleanKeywords()
          })
        }
      }
      .padding({ right: 52 })
      .backgroundColor('#FFFFFF')
      .borderRadius(16)
    }
    .padding({ left: 20, right: 20 })
    .margin({ top: 12, bottom: 5 })
  }
}