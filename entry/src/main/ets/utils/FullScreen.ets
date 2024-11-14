import { window } from '@kit.ArkUI'

// context 是应用上下文，应用提供的一些功能对象
// 1. 组件中 getContext(this) 获取， this 组件实例, 如果是在非组件调用获取的是 undefined
// 2. 在 Ability 中，this.context 可以获取上下文

class FullScreen {
  // 开启全屏
  async enable() {
    const ctx = AppStorage.get<Context>('context')
    if (ctx) {
      const win = await window.getLastWindow(ctx)
      // true 开启沉浸式
      win.setWindowLayoutFullScreen(true)


      //在应用中存储顶部安全高度
      const top = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM).topRect
      AppStorage.setOrCreate<number>('topRectHeight', px2vp(top.height))
      //在应用中存储底部安全高度
      const bottom = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR).bottomRect
      AppStorage.setOrCreate<number>('bottomRectHeight', px2vp(bottom.height))
    }
  }

  // 关闭全屏
  async disable() {
    const ctx = AppStorage.get<Context>('context')
    if (ctx) {
      const win = await window.getLastWindow(ctx)
      // false 关闭沉浸式
      win.setWindowLayoutFullScreen(false)
    }
  }
}

export const fullScreen = new FullScreen()