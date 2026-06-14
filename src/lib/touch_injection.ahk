PT_TOUCH := 2

POINTER_FLAG_INRANGE    := 0x00000002
POINTER_FLAG_INCONTACT  := 0x00000004
POINTER_FLAG_DOWN       := 0x00010000
POINTER_FLAG_UPDATE     := 0x00020000
POINTER_FLAG_UP         := 0x00040000

class TouchInjector {
    static _Initialized := false
    static _Down := false
    static _LastX := 0
    static _LastY := 0
    static LastError := 0

    static Init(maxCount := 3, feedbackMode := 1) {
        result := DllCall("User32.dll\InitializeTouchInjection", "UInt", maxCount, "UInt", feedbackMode, "Int")
        if (!result) {
            this.LastError := A_LastError
            return false
        }
        this._Initialized := true
        this.LastError := 0
        return true
    }

    static _WriteFields(buf, x, y, flags) {
        NumPut("UInt", PT_TOUCH, buf, 0)
        NumPut("UInt", 0, buf, 4)
        NumPut("UInt", flags, buf, 12)
        NumPut("Int", x, buf, 32)
        NumPut("Int", y, buf, 36)
        NumPut("UInt", 7, buf, 100)
        NumPut("UInt", 90, buf, 136)
        NumPut("UInt", 32000, buf, 140)
        NumPut("Int", x-2, buf, 104)
        NumPut("Int", y-2, buf, 108)
        NumPut("Int", x+2, buf, 112)
        NumPut("Int", y+2, buf, 116)
    }

    static _Inject(flags) {
        buf := Buffer(144, 0)
        this._WriteFields(buf, this._LastX, this._LastY, flags)
        result := DllCall("User32.dll\InjectTouchInput", "UInt", 1, "Ptr", buf, "Int")
        if (!result) {
            this.LastError := A_LastError
            return false
        }
        this.LastError := 0
        return true
    }

    ; 解析坐标，省略则用鼠标位置
    static _ResolveCoord(x?, y?) {
        if (!IsSet(x) || !IsSet(y)) {
            CoordMode("Mouse", "Screen")
            MouseGetPos(&mx, &my)
            if (!IsSet(x))
                x := mx
            if (!IsSet(y))
                y := my
        }
        this._LastX := x
        this._LastY := y
    }

    ; 按下
    static Down(x?, y?) {
        if (!this._Initialized) {
            this.LastError := 87
            return false
        }
        if (this._Down) {
            this.LastError := 87
            return false
        }
        this._ResolveCoord(x?, y?)
        if (!this._Inject(POINTER_FLAG_INRANGE | POINTER_FLAG_INCONTACT | POINTER_FLAG_DOWN))
            return false
        this._Down := true
        return true
    }

    ; 抬起
    static Up(x?, y?) {
        if (!this._Initialized || !this._Down) {
            this.LastError := 87
            return false
        }

        this._ResolveCoord(x?, y?)
        if (!this._Inject(POINTER_FLAG_INRANGE | POINTER_FLAG_INCONTACT | POINTER_FLAG_UPDATE))
            return false
        if (!this._Inject(POINTER_FLAG_UP))
            return false
        this._Down := false
        return true
    }

    ; 点击
    static Tap(x?, y?) {
        if (!this.Down(x?, y?))
            return false
        return this.Up(x?, y?)
    }
}

TouchInjector.Init(3, 1)