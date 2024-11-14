import CustomAddDialog from '../../component/CustomAddDialog'
import CustomEditDialog from '../../component/CustomEditDialog'
import CustomSearch from '../../component/CustomSearch'
import CustomTitle from '../../component/CustomTitle'
import MimoItem from '../../component/MimoItem'
import MimoTable from '../../database/MimoTable'
import MimoModel from '../../model/MimoModel'


@Entry
@Component
struct NoteBook {
  @StorageProp("topHeight") topHeight: number = 0
  @State @Watch('onOrderChange') order: boolean = true
  @State list: string = '顺序排序'
  @State isAddDialog: boolean = false
  @State isEditDialog: boolean = false
  // 编辑弹窗文本输入的暂存内容
  @State editContent: string = ''
  // 页面中展示的memo列表
  @State mimoList: MimoModel[] = []
  // 缓存列表
  originList: MimoModel[] = []
  // 搜索关键词
  @State @Watch('onKeywordsChange') keyWord: string = ''
  // 当前编辑的memo索引
  editingMimoIndex: number = -1
  @State mimo: MimoModel = {
    id: 0,
    updateTime: 0,
    content: ''
  }
  // 数据库初始化
  private MimoTable = new MimoTable(() => {
  })

  aboutToAppear(): void {
    this.originList = []
    this.mimoList = []
    //this.order = false
    this.keyWord = ''
    this.isAddDialog = false
    this.isEditDialog = false
    this.editContent = ''
    this.editingMimoIndex = -1
    this.MimoTable.getRdbStore(() => {
      this.MimoTable.query((mimo: MimoModel[]) => {
        this.originList = mimo
        this.mimoList = this.originList
        this.onOrderChange()
      })
    })
  }

  onClickMimo = (mimo: MimoModel) => {
    // for (let i = 0; i < this.originList.length; i++) {
    //   this.originList[i].id = mimo.id
    //   this.editingMimoIndex = i
    //   this.isEditDialog = true
    //   this.editContent = mimo.content
    // }
    // console.log(this.editingMimoIndex.toString())
    this.isEditDialog = true
    this.editingMimoIndex = this.originList.indexOf(mimo)
    this.mimo = {
      id: mimo.id,
      updateTime: mimo.updateTime,
      content: mimo.content
    }
    this.editContent = mimo.content
  }

  // 删除笔记
  @Builder
  itemEnd(mimo: MimoModel) {
    Row() {
      Button("删除")
        .height('100%')
        .width('100%')
        .type(ButtonType.Normal)
        .backgroundColor(Color.Red)
        .borderRadius(10)
        .onClick(() => {
          AlertDialog.show({
            title: '警告!!!',
            primaryButton: {
              value: '取消',
              action: () => {
              },
            },
            secondaryButton: {
              value: '删除',
              action: () => {
                let index = this.mimoList.indexOf(mimo)
                this.editingMimoIndex = index
                //this.mimoList.splice(index, 1)
                this.deleteMimo()
              }
            },
            message: '确定要删除吗?'
          })
        })
    }
    .justifyContent(FlexAlign.SpaceEvenly)
    .width(90)
    .height(90)
    .margin({ top: 12 })
    .padding({ right: 10 })
  }

  onOrderChange() {
    let orderList: MimoModel[] = []
    orderList = this.mimoList.sort((timeA: MimoModel, timeB: MimoModel) => {
      if (this.order) {
        return timeA.updateTime - timeB.updateTime
      } else {
        return timeB.updateTime - timeA.updateTime
      }
    })

    this.mimoList = orderList
  }

  // 清空搜索关键词的方法
  cleanKeywords = () => {
    this.keyWord = ''
  }

  // 监听搜索关键词的过滤方法
  onKeywordsChange() {
    if (this.keyWord.length === 0) {
      this.mimoList = this.originList
      this.onOrderChange()
    } else {
      let resultList: MimoModel[] = []

      for (const mimoItem of this.originList) {
        if (mimoItem.content.includes(this.keyWord)) {
          resultList.push(mimoItem)
        }
      }
      this.mimoList = resultList
    }
  }

  // 新增笔记
  creatMimo = (mimo: MimoModel) => {
    // const date: Date = new Date()
    // const mimo: MimoModel = new MimoModel()
    this.MimoTable.insertData(mimo, (id: number) => {
      mimo.id = id
      this.originList.push(mimo)
      this.mimoList = this.originList
      this.onOrderChange()
      this.closeDialog()
    })


  }
  // 新增笔记
  addMimo = () => {
    const date: Date = new Date()
    this.mimo = { id: date.getTime(), updateTime: date.getTime(), content: this.editContent }
    this.creatMimo(this.mimo)
    this.editContent = ''
    this.closeDialog()
  }
  // 修改笔记
  updateMimo = () => {
    const date: Date = new Date()
    this.originList[this.editingMimoIndex].updateTime = date.getTime()
    this.originList[this.editingMimoIndex].content = this.editContent

    this.MimoTable.updateData(this.originList[this.editingMimoIndex], () => {
      this.mimoList = this.originList
      this.onOrderChange()
      this.closeDialog()
    })
  }
  // 关闭弹窗的方法
  closeDialog = () => {
    this.isAddDialog = false
    this.isEditDialog = false
    this.editingMimoIndex = -1
    this.editContent = ''
  }
  // 删除笔记
  deleteMimo = () => {
    if (this.editingMimoIndex !== -1) {
      this.MimoTable.deleteData(this.originList[this.editingMimoIndex], () => {
        this.originList.splice(this.editingMimoIndex, 1)
        this.mimoList = this.originList
        this.onOrderChange()
        this.closeDialog()
      })
    }
  }

  build() {
    Stack() {
      // 背景
      Image($r('app.media.bg'))
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Cover)

      // 主体部分
      Column() {
        CustomTitle({
          order: $order,
          isAddDialog: $isAddDialog
        })

        Divider()
          .color('#604637')

        // 搜索
        CustomSearch({ keyWord: $keyWord, cleanKeywords: this.cleanKeywords })

        // 笔记列表
        List() {
          ForEach(this.mimoList, (mimo: MimoModel, index: number) => {
            ListItem() {
              MimoItem({
                mimo: mimo,
                onMimoClick: this.onClickMimo
              })
            }
            .swipeAction({
              end: {
                builder: () => {
                  this.itemEnd(mimo)
                },
                // onAction: () => {
                //   animateTo({ duration: 1000 }, () => {
                //
                //   })
                // },
                // actionAreaDistance: 60,
              }
            })
          }, (mimo: MimoModel) => mimo.content)
        }
        .width('100%')
        .padding({ bottom: 125 })

      }
      .width('100%')
      .height('100%')


      // 编辑弹窗

      if (this.isEditDialog) {
        CustomEditDialog({
          editContent: $editContent,
          onClose: this.closeDialog,
          onUpdate: this.updateMimo,
          onDelete: this.deleteMimo
        })
      }

      if (this.isAddDialog) {
        CustomAddDialog({
          editContent: $editContent,
          onClose: this.closeDialog,
          onAdd: this.addMimo
        })
      }

    }
    .width('100%')
    .height('100%')
    .padding({ top: this.topHeight })

  }
}