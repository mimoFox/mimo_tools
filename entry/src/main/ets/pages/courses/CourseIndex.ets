import { promptAction, router } from '@kit.ArkUI';
import course from '../../../resources/rawfile/output.json';
import { CourseModel } from '../../utils/ParseJsonFile';
import { media } from '@kit.MediaKit';
import { AVPlayerUtils } from '../../utils/avPlayerUtils';

@Entry
@Component
struct CourseIndex {
  @State JsonData: CourseModel[] = []
  @State questionWord: string = ''
  @State answerWord: string = ''
  @State phonetic: string = ''
  @State soundUrl: string = ''
  @State currentIndex: number = 0
  @State count: number = 0
  @State currentState: string = 'question' || 'answer'
  @State inputValue: string = ''
  private avPlayer: media.AVPlayer | null = null
  private avPlay: AVPlayerUtils | null = null

  async onPageShow(): Promise<void> {
    this.JsonData = [{
      chapter: '',
      words: course
    }]
    this.updateWord()

    this.avPlayer = await media.createAVPlayer()
    this.avPlay?.setAVPlayerCallback(this.avPlayer)
  }

  updateWord() {
    if (this.currentIndex < 0 || this.currentIndex >= this.JsonData[0].words.length) {
      return;
    }
    this.questionWord = this.JsonData[0].words[this.currentIndex].chinese
    this.answerWord = this.JsonData[0].words[this.currentIndex].english
    this.phonetic = this.JsonData[0].words[this.currentIndex].phonetic
    this.soundUrl = `http://dict.youdao.com/dictvoice?type=0&audio=${this.answerWord}`
  }

  // 检查输入是否正确
  checkValidity(inputValue: string) {
    return inputValue.toLowerCase() === this.answerWord.toLowerCase()
  };

  // // 显示答案
  handleCheckAnswer(userInput: string) {
    if (userInput.replace(/\s+/g, ' ').replace(/[^\w\s]/gi, '').trim() ===
    this.answerWord.toLowerCase()
      .replace(/\s+/g, ' ')
      .replace(/[^\w\s]/gi, '')
      .trim()
    ) {
      this.currentState = 'answer'
      this.count = 0
    } else {
      this.count++;
      console.log('错误')

      if (this.count > 2) {
        this.currentState = 'answer'
        this.count = 0;
        promptAction.showToast({
          duration: 500,
          message: '错误次数过多'
        })
      }
    }
    // 发音
  }

  // 跳转上一题
  preQuestion() {
    this.currentIndex--;
    if (this.currentIndex <= 0) {
      this.currentIndex = 0
      promptAction.showToast({
        duration: 500,
        message: '已经是第一个了'
      })
      return
    }
    if (this.currentIndex >= 0) {
      this.currentState = 'question'
      this.updateWord();
    }

  }

  // 跳转下一题
  nextQuestion() {
    this.currentIndex++;
    if (this.currentIndex >= this.JsonData[0].words.length) {
      this.currentIndex = this.JsonData[0].words.length - 1
      promptAction.showToast({
        duration: 500,
        message: '已经是最后一个了'
      })
      return
    }
    if (this.currentIndex <= this.JsonData[0].words.length) {
      this.currentState = 'question'
      this.updateWord();
    }

  }

  @Builder
  Back() {
    Row() {
      Button("<<<")
        .type(ButtonType.Normal)
        .borderRadius(10)
        .backgroundColor(Color.Transparent)
        .fontColor(Color.Black)
        .width(100)
        .height(50)
        .fontSize(30)
        .onClick(() => {
          router.back({ url: 'pages/Index' });
        })


    }
    .width('100%')
    .height(60)
    .justifyContent(FlexAlign.SpaceBetween)
  }

  build() {
    Column() {
      Text('英语练习')
        .margin({ top: 80 })
        .fontSize(40)
        .fontWeight(600)
        .fontColor('#ff1d98fa')

      // 显示卡片
      Stack() {
        Row() {
          ForEach(this.JsonData, (item: CourseModel) => {
            if (this.currentState === 'question' && this.currentIndex >= 0) {
              Text(item.words[this.currentIndex].chinese)
                .fontSize(38)
                .fontWeight(500)
                .fontColor('#ff000000')
            } else if (this.currentState === 'answer') {
              Column() {
                Text(item.words[this.currentIndex].english)
                  .fontSize(38)
                  .fontWeight(500)
                  .fontColor('#fff86d55')
                Text(item.words[this.currentIndex].phonetic)
                  .fontSize(38)
                  .fontWeight(500)
                  .fontColor('#fffa47ff')
                // Video({
                //   src: this.soundUrl,
                //   controller: this.controller,
                //   previewUri: this.previewUris
                // })

                Text('播放')
                  .border({ width: 1 })
                  .onClick(() => {
                    this.onPageShow()
                    this.avPlay?.avPlayerLiveDemo(this.soundUrl)
                  })
                  .margin({ top: 10 })

              }
            }
          })
        }
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.Center)
        .width('100%')
        .height('100%')
        .backgroundColor("#fff1f1f1")
        .borderRadius(10)
        .margin({ top: 20 })
        .shadow({
          radius: 10,
          offsetY: 10,
          offsetX: 10,
          color: '#ffb8b8b8'
        })

        Row() {
          Button("<")
            .type(ButtonType.Normal)
            .borderRadius(10)
            .backgroundColor(Color.Transparent)
            .fontColor(Color.Black)
            .fontSize(30)
            .onClick(() => {
              this.preQuestion()
              this.inputValue = ''
            })

          Button(">")
            .type(ButtonType.Normal)
            .borderRadius(10)
            .backgroundColor(Color.Transparent)
            .fontColor(Color.Black)
            .fontSize(30)
            .onClick(() => {
              this.nextQuestion()
              this.inputValue = ''
            })
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Bottom)
      }
      .width('100%')
      .height(180)

      TextInput({ placeholder: '请输入正确的英语', text: this.inputValue })
        .type(InputType.Normal)
        .width('100%')
        .height(100)
        .fontSize(24)
        .fontWeight(500)
        .backgroundColor(Color.Transparent)
        .textAlign(TextAlign.Center)
        .onChange((value: string) => {
          this.inputValue = value
        })
        .onKeyEvent((e) => {
          if (e.keyCode === 13) {
            this.handleCheckAnswer(this.inputValue)

          }
        })

      Button('确定')
        .type(ButtonType.Normal)
        .borderRadius(10)
        .backgroundColor(Color.Transparent)
        .fontColor(Color.Black)
        .fontSize(30)
        .width(100)
        .height(50)
        .onClick(() => {
          this.handleCheckAnswer(this.inputValue)
          console.log('Q--' + this.answerWord)

        })
    }
    .width('100%')
    .height('100%')
    .overlay(this.Back(), {
      align: Alignment.TopStart
    })
    .padding({ left: 10, right: 10 })
    .backgroundColor('#fffcf9cd')

  }
}

