; == 功能实现 ==
; -- 常规作战 --
; 按下暂停
ActionPressPause(ThisHotkey) {
    if !IsInLevel() {
        return
    }
    Send "{ESC Down}"
    USleep(50)
    Send "{ESC Up}"
    if InStr(ThisHotkey, "Wheel")
        return
    PureKeyWait(ThisHotkey)
}
; 松开暂停
ActionReleasePause(ThisHotkey) {
    Send "{Space Down}"
    USleep(50)
    Send "{Space Up}"
}
; 切换倍速
ActionGameSpeed(ThisHotkey) {
    Send "{f Down}"
    Send "{g Down}"
    USleep(50)
    Send "{f Up}"
    Send "{g Up}"
    if InStr(ThisHotkey, "Wheel")
        return
    PureKeyWait(ThisHotkey)
}
; 前进16ms
Action16ms(ThisHotkey) {
    if !IsInLevel() {
        return
    }
    try oldCtx := DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
    if !IsMouseInClient() {
        try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
        return
    }
    delay := Integer(Config.GetCustom("FrameSkip16msDelay"))
    Send "{ESC Down}"
    USleep(delay)
    Send "{Space Down}"
    USleep(50)
    Send "{ESC Up}"
    Send "{Space Up}"
    if InStr(ThisHotkey, "Wheel") {
        try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
        return
    }
    PureKeyWait(ThisHotkey)
    try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
}
; 前进33ms，由于波动，过帧间隔设置为30ms，避免一次过两帧
Action33ms(ThisHotkey) {
    if !IsInLevel() {
        return
    }
    try oldCtx := DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
    if !IsMouseInClient() {
        try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
        return
    }
    delay := Integer(Config.GetCustom("FrameSkip33msDelay"))
    Send "{ESC Down}"
    USleep(delay)
    Send "{Space Down}"
    USleep(50)
    Send "{ESC Up}"
    Send "{Space Up}"
    if InStr(ThisHotkey, "Wheel") {
        try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
        return
    }
    PureKeyWait(ThisHotkey)
    try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
}
; 前进166ms
Action166ms(ThisHotkey) {
    if !IsInLevel() {
        return
    }
    try oldCtx := DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
    if !IsMouseInClient() {
        try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
        return
    }
    delay := Integer(Config.GetCustom("FrameSkip166msDelay"))
    Send "{ESC Down}"
    USleep(delay)
    Send "{Space Down}"
    USleep(50)
    Send "{ESC Up}"
    Send "{Space Up}"
    if InStr(ThisHotkey, "Wheel") {
        try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
        return
    }
    PureKeyWait(ThisHotkey)
    try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
}
; 暂停选中
ActionPauseSelect(ThisHotkey) {
    if !IsInLevel() {
        return
    }
    try oldCtx := DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
    if !IsMouseInClient() {
        try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
        return
    }
    PosL := PauseButtonPositionLeft()
    PosR := PauseButtonPositionRight()
    MouseGetPos &xpos, &ypos
    TouchInjector.Tap(PosL.PBLX, PosL.PBLY)
    TouchInjector.Tap(xpos, ypos)
    TouchInjector.Tap(PosR.PBRX, PosR.PBRY)
    USleep(State.CurrentDelay * 1.5)
    TouchInjector.Move(xpos, ypos)
    MouseMove xpos, ypos
    if InStr(ThisHotkey, "Wheel") {
        try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
        return
    }
    PureKeyWait(ThisHotkey)
    try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
}
; 干员技能
ActionSkill(ThisHotkey) {
    Send "{e Down}"
    USleep(50)
    Send "{e Up}"
    if InStr(ThisHotkey, "Wheel")
        return
    PureKeyWait(ThisHotkey)
}
; 干员撤退
ActionRetreat(ThisHotkey) {
    Send "{q Down}"
    USleep(50)
    Send "{q Up}"
    if InStr(ThisHotkey, "Wheel")
        return
    PureKeyWait(ThisHotkey)
}
; 一键技能
ActionOneClickSkill(ThisHotkey) {
    if !IsInLevel() {
        return
    }
    try oldCtx := DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
    if !IsMouseInClient() {
        try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
        return
    }
    Send "{LButton Down}"
    Send "{LButton Up}"
    USleep(State.ClickDelay)
    Send "{e Down}"
    USleep(50)
    Send "{e Up}"
    if InStr(ThisHotkey, "Wheel") {
        try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
        return
    }
    PureKeyWait(ThisHotkey)
    try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
}
; 一键撤退
ActionOneClickRetreat(ThisHotkey) {
    if !IsInLevel() {
        return
    }
    try oldCtx := DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
    if !IsMouseInClient() {
        try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
        return
    }
    Send "{LButton Down}"
    Send "{LButton Up}"
    USleep(State.ClickDelay)
    Send "{q Down}"
    USleep(50)
    Send "{q Up}"
    if InStr(ThisHotkey, "Wheel") {
        try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
        return
    }
    PureKeyWait(ThisHotkey)
    try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
}
; 暂停技能
ActionPauseSkill(ThisHotkey) {
    if !IsInLevel() {
        return
    }
    try oldCtx := DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
    if !IsMouseInClient() {
        try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
        return
    }
    PosL := PauseButtonPositionLeft()
    PosR := PauseButtonPositionRight()
    MouseGetPos &xpos, &ypos
    TouchInjector.Tap(PosL.PBLX, PosL.PBLY)
    TouchInjector.Tap(xpos, ypos)
    TouchInjector.Tap(PosR.PBRX, PosR.PBRY)
    USleep(State.ClickDelay)
    Send "{e Down}"
    USleep(Max(State.CurrentDelay * 1.5 - State.ClickDelay, 0))
    TouchInjector.Move(xpos, ypos)
    MouseMove xpos, ypos
    USleep(50)
    Send "{e Up}"
    if InStr(ThisHotkey, "Wheel") {
        try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
        return
    }
    PureKeyWait(ThisHotkey)
    try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
}
; 暂停撤退
ActionPauseRetreat(ThisHotkey) {
    if !IsInLevel() {
        return
    }
    try oldCtx := DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
    if !IsMouseInClient() {
        try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
        return
    }
    PosL := PauseButtonPositionLeft()
    PosR := PauseButtonPositionRight()
    MouseGetPos &xpos, &ypos
    TouchInjector.Tap(PosL.PBLX, PosL.PBLY)
    TouchInjector.Tap(xpos, ypos)
    TouchInjector.Tap(PosR.PBRX, PosR.PBRY)
    USleep(State.ClickDelay)
    Send "{q Down}"
    USleep(Max(State.CurrentDelay * 1.5 - State.ClickDelay, 0))
    TouchInjector.Move(xpos, ypos)
    MouseMove xpos, ypos
    USleep(50)
    Send "{q Up}"
    if InStr(ThisHotkey, "Wheel") {
        try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
        return
    }
    PureKeyWait(ThisHotkey)
    try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
}

; 视角切换
ActionSwitchView(ThisHotkey) {
    if !IsInLevel() {
        return
    }
    try oldCtx := DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
    if !IsMouseInClient() {
        try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
        return
    }
    PosL := PauseButtonPositionLeft()
    PosR := PauseButtonPositionRight()
    MouseGetPos &xpos, &ypos
    TouchInjector.Tap(PosL.PBLX, PosL.PBLY)
    TouchInjector.Tap(xpos, ypos)
    TouchInjector.Tap(PosR.PBRX, PosR.PBRY)
    TouchInjector.Tap(xpos, ypos)
    if InStr(ThisHotkey, "Wheel") {
        try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
        return
    }
    PureKeyWait(ThisHotkey)
    try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
}
; 开局暂停
ActionBeginPause() {
    try oldCtx := DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
    PosC := SpeedButtonPositionColor()
    while(true) {
        ; ToolTip("正在识别按钮！")  ; 调试代码
        if PixelSearch(&FoundX, &FoundY, PosC.PBCRX, PosC.PBCUY, PosC.PBCLX, PosC.PBCDY, 0xffffff, 10)
        {
            if !IsInLevel() {
                State.BlackScreenDetected := false
                State.ReadyForPause := false
                SetTimer CheckGameStatus, 400
                return
            }
            Send "{ESC Down}"
            USleep(50)
            Send "{ESC Up}"
            ; ToolTip("已严肃暂停")  ; 调试代码
            ; 为了降低暂停延迟，后置代理指挥识别，识别到是代理指挥时取消暂停
            TobC := TakeOverButtonPositions()

            ; 第一层：线点识别（精确，优先）
            isProxy := false
            ; pointInfo := [] ; 调试代码
            ; for point in TobC.LinePoints {
            ;     if !PixelSearch(&FoundX, &FoundY, point.LX, point.Y, point.RX, point.Y, point.C, 20)
            ;     {
            ;         isProxy := false
            ;         ; ToolTip("线点检测不通过：" . point.LX . " " . point.Y . "→" . point.RX . " " . point.Y . " " . Format("{1:X}", point.C) . " " . "实际识别到的：" . PixelGetColor(point.LX, point.Y))
            ;         break
            ;     }
            ;     ; color := PixelGetColor(point.x, point.y)
            ;     ; pointInfo.Push(Format("({:.0f},{:.0f})={:#x}", point.x, point.y, color)) ; 调试代码
            ; }

            ; 第二层：ImageSearch 兜底（线点漏检时补救）
            if !isProxy {
                if ImageSearch(&OutputVarX, &OutputVarY, TobC.ImageRegion.LX, TobC.ImageRegion.UY, TobC.ImageRegion.RX, TobC.ImageRegion.DY, "*90 " FileExtractor.TakeOver1Path) or ImageSearch(&OutputVarX, &OutputVarY, TobC.ImageRegion.LX, TobC.ImageRegion.UY, TobC.ImageRegion.RX, TobC.ImageRegion.DY, "*90 " FileExtractor.TakeOver2Path) { ; 0 帧暂停接管按钮半透明导致至少需要 90 容错
                    isProxy := true
                }
            } 
            ; else 
            ;     ToolTip("图像识别不通过")

            if isProxy {
                Send "{ESC Down}"
                USleep(50)
                Send "{ESC Up}"
                ; ToolTip("是代理指挥，取消暂停")  ; 调试代码
            } else {
                ; ToolTip("没有找到代理指挥")  ; 调试代码
            }

            State.BlackScreenDetected := false
            State.ReadyForPause := false
            SetTimer CheckGameStatus, 400
            break
        }
    }
    try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
}

; -- 快捷操作 --
; 模拟鼠标左键点击
ActionLButtonClick(ThisHotkey) {
    try oldCtx := DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
    if !IsMouseInClient() {
        try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
        return
    }
    Send "{LButton Down}"
    if InStr(ThisHotkey, "Wheel") {
        Send "{LButton Up}"
        try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
        return
    }
    PureKeyWait(ThisHotkey)
    Send "{LButton Up}"
    try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
}
; 放弃行动
ActionCeaseOperations(ThisHotkey) {
    Send "{v Down}"
    Send "{ESC Down}"
    USleep(50)
    Send "{v Up}"
    Send "{ESC Up}"
    if InStr(ThisHotkey, "Wheel")
        return
    PureKeyWait(ThisHotkey)
}
; 跳过招募动画/剧情
ActionSkip(ThisHotkey) {
    try oldCtx := DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
    if !IsMouseInClient() {
        try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
        return
    }
    Pos := PauseButtonPosition()
    MouseGetPos &xpos, &ypos
    BlockInput "MouseMove"
    MouseMove Pos.PBX, Pos.PBY
    Send "{Lbutton Down}"
    MouseMove Pos.PBX, Pos.PBY
    Send "{LButton Up}"
    USleep(40)
    MouseMove xpos, ypos
    BlockInput "MouseMoveOff"
    if InStr(ThisHotkey, "Wheel") {
        try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
        return
    }
    PureKeyWait(ThisHotkey)
    try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
}
; 返回上级菜单
ActionBack(ThisHotkey) {
    Send "{v Down}"
    Send "{ESC Down}"
    USleep(50)
    Send "{v Up}"
    Send "{ESC Up}"
    if InStr(ThisHotkey, "Wheel")
        return
    PureKeyWait(ThisHotkey)
}
; 基建快速收取
ActionHarvest(ThisHotkey) {
    try oldCtx := DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
    if !IsMouseInClient() {
        try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
        return
    }
    Pos := HarvestButtonPosition()
    MouseGetPos &xpos, &ypos
    BlockInput "MouseMove"
    MouseMove Pos.PBX, Pos.PBY
    Send "{Lbutton Down}"
    MouseMove Pos.PBX, Pos.PBY
    Send "{LButton Up}"
    USleep(40)
    MouseMove xpos, ypos
    BlockInput "MouseMoveOff"
    if InStr(ThisHotkey, "Wheel") {
        try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
        return
    }
    PureKeyWait(ThisHotkey)
    try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
}
; 肉鸽收集藏品
ActionCollectCollectibles(ThisHotkey){
    try oldCtx := DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
    if !IsMouseInClient() {
        try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
        return
    }
    Pos := CollectButtonPosition()
    MouseGetPos &xpos, &ypos
    BlockInput "MouseMove"
    MouseMove Pos.PBX, Pos.PBY
    Send "{Lbutton Down}"
    MouseMove Pos.PBX, Pos.PBY
    Send "{LButton Up}"
    USleep(40)
    MouseMove xpos, ypos
    BlockInput "MouseMoveOff"
    if InStr(ThisHotkey, "Wheel") {
        try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
        return
    }
    PureKeyWait(ThisHotkey)
    try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
}
; -- 卫戍协议 --
; 查看敌人
ActionCheckEnemies(ThisHotkey) {
    Send "{w Down}"
    USleep(50)
    Send "{w Up}"
    if InStr(ThisHotkey, "Wheel")
        return
    PureKeyWait(ThisHotkey)
}
; 调度中心
ActionDispatchCenter(ThisHotkey) {
    Send "{a Down}"
    USleep(50)
    Send "{a Up}"
    if InStr(ThisHotkey, "Wheel")
        return
    PureKeyWait(ThisHotkey)
}
; 冻结
ActionFreeze(ThisHotkey) {
    Send "{s Down}"
    USleep(50)
    Send "{s Up}"
    if InStr(ThisHotkey, "Wheel")
        return
    PureKeyWait(ThisHotkey)
}
; 刷新
ActionRefresh(ThisHotkey) {
    Send "{d Down}"
    USleep(50)
    Send "{d Up}"
    if InStr(ThisHotkey, "Wheel")
        return
    PureKeyWait(ThisHotkey)
}
; 升级
ActionUpgrade(ThisHotkey) {
    Send "{g Down}"
    USleep(50)
    Send "{g Up}"
    if InStr(ThisHotkey, "Wheel")
        return
    PureKeyWait(ThisHotkey)
}
; 出售/销毁
ActionSell(ThisHotkey) {
    Send "{x Down}"
    USleep(50)
    Send "{x Up}"
    if InStr(ThisHotkey, "Wheel")
        return
    PureKeyWait(ThisHotkey)
}
; 准备就绪
ActionReady(ThisHotkey) {
    Send "{c Down}"
    USleep(50)
    Send "{c Up}"
    if InStr(ThisHotkey, "Wheel")
        return
    PureKeyWait(ThisHotkey)
}
; 一键出售/销毁
ActionOneClickSell(ThisHotkey) {
    try oldCtx := DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
    if !IsMouseInClient() {
        try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
        return
    }
    Send "{LButton Down}"
    Send "{LButton Up}"
    USleep(State.ClickDelay)
    Send "{x Down}"
    USleep(50)
    Send "{x Up}"
    if InStr(ThisHotkey, "Wheel") {
        try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
        return
    }
    PureKeyWait(ThisHotkey)
    try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
}
; 一键购买
ActionOneClickPurchase(ThisHotkey) {
    try oldCtx := DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
    if !IsMouseInClient() {
        try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
        return
    }
    Send "{LButton Down}"
    Send "{LButton Up}"
    USleep(60)
    Send "{LButton Down}"
    Send "{LButton Up}"
    if InStr(ThisHotkey, "Wheel") {
        try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
        return
    }
    PureKeyWait(ThisHotkey)
    try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
}

; == 工具函数 ==
; 高精度延迟
USleep(delay_ms) {
    if (delay_ms <= 0)
        return
    static freq := 0
    if (freq = 0)
        DllCall("QueryPerformanceFrequency", "Int64*", &freq)
    start := 0
    DllCall("QueryPerformanceCounter", "Int64*", &start)
    target := start + (delay_ms * freq / 1000)
    current := 0
    Loop {
        DllCall("QueryPerformanceCounter", "Int64*", &current)
        if (current >= target)
            break
        remaining := (target - current) * 1000 / freq
        if (remaining > 4)
            DllCall("Sleep", "UInt", 1)
    }
}
; 去除修饰符前缀
PureKeyWait(ThisHotkey) {
    if (ThisHotkey == "") 
        return
    pureKey := RegExReplace(ThisHotkey, "^[~*$!^+#&<>()]+")
    KeyWait(pureKey)
}
; 判断鼠标是否在Client区域内
IsMouseInClient() {
    MouseGetPos , &ypos, &hwnd
    gameHwnd := WinExist("ahk_exe Arknights.exe")
    if !(hwnd == gameHwnd)
        return false
    ; 简单判断会不会点到最小化或者关闭窗口
    if ypos < 0
        return false
    return true
}
; 获取放弃按钮位置
AbandonButtonPosition() {
    WinGetClientPos ,, &ww, &wh, "ahk_exe Arknights.exe"
    PButtonLX := ww * 0.0474
    PButtonRX := ww * 0.0734
    PButtonUY := wh * 0.0444
    PButtonDY := wh * 0.0694
    return {PBLX: PButtonLX, PBUY: PButtonUY, PBRX: PButtonRX, PBDY: PButtonDY}
}
; 关卡界面检测
IsInLevel() {
    AbdC := AbandonButtonPosition()
    if PixelSearch(&FoundX, &FoundY, AbdC.PBRX, AbdC.PBDY, AbdC.PBLX, AbdC.PBUY, 0x8c8c8c, 0) {
        return true
    }
    return false
}
; 获取暂停按钮位置
PauseButtonPosition() {
    WinGetClientPos ,, &ww, &wh, "ahk_exe Arknights.exe"
    PButtonX := ww * 0.9525
    PButtonY := wh * 0.0700
    return {PBX: PButtonX, PBY: PButtonY}
}
; 获取暂停按钮左半部分位置
PauseButtonPositionLeft() {
    WinGetClientPos ,, &ww, &wh, "ahk_exe Arknights.exe"
    PButtonLX := ww * 0.9400
    PButtonLY := wh * 0.0700
    return {PBLX: PButtonLX, PBLY: PButtonLY}
}
; 获取暂停按钮右半部分位置
PauseButtonPositionRight() {
    WinGetClientPos ,, &ww, &wh, "ahk_exe Arknights.exe"
    PButtonRX := ww * 0.9650
    PButtonRY := wh * 0.0700
    return {PBRX: PButtonRX, PBRY: PButtonRY}
}
; 获取自动暂停倍速按钮识别位置
SpeedButtonPositionColor() {
    WinGetClientPos ,, &ww, &wh, "ahk_exe Arknights.exe"
    PButtonCLX := ww * 0.8450
    PButtonCRX := ww * 0.8807
    PButtonCUY := wh * 0.0713
    PButtonCDY := wh * 0.0870
    return {PBCLX: PButtonCLX, PBCRX: PButtonCRX, PBCUY: PButtonCUY, PBCDY: PButtonCDY}
}
; 获取基建收取按钮位置
HarvestButtonPosition() {
    WinGetClientPos ,, &ww, &wh, "ahk_exe Arknights.exe"
    PButtonX := ww * 0.1297
    PButtonY := wh * 0.9527
    return {PBX: PButtonX, PBY: PButtonY}
}
; 获取代理接管作战按钮识别位置（线点识别 + 图像识别）
TakeOverButtonPositions() {
    WinGetClientPos ,, &ww, &wh, "ahk_exe Arknights.exe"

    ; ; === 线点识别坐标 ===
    ; X1 := ww * 0.332031, X2 := ww * 0.336914, X3 := ww * 0.342285
    ; X4 := ww * 0.347167, X5 := ww * 0.352539, X6 := ww * 0.357421
    ; X7 := ww * 0.362792, X8 := ww * 0.367675, X9 := ww * 0.373046

    ; UY  := wh * 0.887962  ; 上方 y
    ; MY  := wh * 0.914814  ; 中线 y
    ; DY  := wh * 0.939814  ; 下方 y

    ; MColor := 0x333333  ; 中线识别颜色
    ; BColor := 0x323232  ; 按钮背景颜色

    ; LinePoints := [
    ;     ; 线识别
    ;     {LX : X2, RX : X8, Y: MY, C: MColor},
    ;     ; 点识别
    ;     {LX : X1, RX : X1, Y: DY, C: BColor}, {LX : X2, RX : X2, Y: DY, C: BColor}, {LX : X3, RX : X3, Y: DY, C: BColor},
    ;     {LX : X4, RX : X4, Y: DY, C: BColor}, {LX : X5, RX : X5, Y: DY, C: BColor}, {LX : X6, RX : X6, Y: DY, C: BColor},
    ;     {LX : X7, RX : X7, Y: DY, C: BColor}, {LX : X8, RX : X8, Y: DY, C: BColor}, {LX : X9, RX : X9, Y: DY, C: BColor}
    ; ]

    ; === ImageSearch 搜索区域 ===
    ImageRegion := {
        LX : ww * 0.3651, RX : ww * 0.4073,
        UY : wh * 0.8685, DY : wh * 0.9546
    }

    ; return {LinePoints: LinePoints, ImageRegion: ImageRegion}
    return {ImageRegion: ImageRegion}
}
; 获取“收下”按钮位置
CollectButtonPosition() {
    WinGetClientPos ,, &ww, &wh, "ahk_exe Arknights.exe"
    PButtonX := ww * 0.1104
    PButtonY := wh * 0.7250
    return {PBX: PButtonX, PBY: PButtonY}
}

; == 工具类 ==
#Include ./touch_injection.ahk