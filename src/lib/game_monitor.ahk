; == 游戏状态监控 ==
; 自动退出计时器
SetTimer CheckGameStatus, 1000

; 检查游戏状态
CheckGameStatus() {
    ; 自动退出
    if (Config.GetImportant("AutoExit") != "1")
        return
    if ProcessExist("Arknights.exe") {
        State.GameHasStarted := true
    }
    else {
        if (State.GameHasStarted == true) {
            ExitApp
        }
    }

    ; 自动开局暂停
    if (Config.GetImportant("AutoBeginPause") == "1" && WinActive("ahk_exe Arknights.exe")) {
        ; 寻找黑屏：遍历 17 个全屏采样点，全部为黑色才判定黑屏
        if (State.BlackScreenDetected == false) {
            try oldCtx := DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
            allBlack := true
            for point in BlackScreenPoints() {
                if !PixelSearch(&FoundX, &FoundY, point.x, point.y, point.x, point.y, 0x050505, 3) {
                    allBlack := false
                    break
                }
            }
            if (allBlack) {
                State.BlackScreenDetected := true
                SetTimer StopSearchLoading, -8000
                SetTimer CheckGameStatus, 500
            }
            try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
        }
        ; 识别 Loading：通过 Loading... 文字区域颜色判断场景类型
        if (State.BlackScreenDetected == true && State.ReadyForPause == false) {
            try oldCtx := DllCall("SetThreadDpiAwarenessContext", "ptr", -3, "ptr")
            PosL := LoadingPosition()
            if PixelSearch(&FoundX, &FoundY, PosL.PLLX, PosL.PLY, PosL.PLRX, PosL.PLY, 0xA60000, 50) {
                State.BlackScreenDetected := false
            } else if PixelSearch(&FoundX, &FoundY, PosL.PLLX, PosL.PLY, PosL.PLRX, PosL.PLY, 0x0070a3, 50){
                State.BlackScreenDetected := false
            } else if PixelSearch(&FoundX, &FoundY, PosL.PLLX, PosL.PLY, PosL.PLRX, PosL.PLY, 0xFFFFFF, 0) {
                State.ReadyForPause := true
                SetTimer StopSearchLoading, 0
                SetTimer ActionBeginPause, -2000
            }
            try DllCall("SetThreadDpiAwarenessContext", "ptr", oldCtx, "ptr")
        }
    }
}

; ==工具函数==
; 获取Loading...颜色识别位置
LoadingPosition() {
    WinGetClientPos ,, &ww, &wh, "ahk_exe Arknights.exe"
    PLoadingLX := ww * 0.835156
    PLoadingRX := ww * 0.976953
    PLoadingY := wh * 0.953472
    return {PLLX: PLoadingLX, PLRX: PLoadingRX, PLY: PLoadingY}
}
; 获取全屏 17 点黑屏采样位置（覆盖四角、四边、内部、中心）
BlackScreenPoints() {
    WinGetClientPos ,, &ww, &wh, "ahk_exe Arknights.exe"
    x5 := ww * 0.05, x25 := ww * 0.25, x50 := ww * 0.5, x75 := ww * 0.75, x95 := ww * 0.95
    y5 := wh * 0.05, y25 := wh * 0.25, y50 := wh * 0.5, y75 := wh * 0.75, y95 := wh * 0.95
    return [
        ; 上边（左→右 5 点）
        {x: x5, y: y5}, {x: x25, y: y5}, {x: x50, y: y5}, {x: x75, y: y5}, {x: x95, y: y5},
        ; 下边（左→右 5 点）
        {x: x5, y: y95}, {x: x25, y: y95}, {x: x50, y: y95}, {x: x75, y: y95}, {x: x95, y: y95},
        ; 左边中点、右边中点
        {x: x5, y: y50}, {x: x95, y: y50},
        ; 内部四点和正中心
        {x: x25, y: y25}, {x: x75, y: y25},
        {x: x50, y: y50},
        {x: x25, y: y75}, {x: x75, y: y75}
    ]
}
; 停止搜索Loading
StopSearchLoading() {
    SetTimer CheckGameStatus, 1000
    State.BlackScreenDetected := false
}