MouseMoveDistance := 70  ; 定义鼠标移动距离变量
#MouseMoveDistanceS := 300  ; 定义鼠标移动距离变量

; 全局变量存储按键状态
wPressed := 0
aPressed := 0
sPressed := 0
dPressed := 0

; 检测按键按下
~CapsLock & w::
    wPressed := 1
    CheckDirection()
return

~CapsLock & a::
    aPressed := 1
    CheckDirection()
return

~CapsLock & s::
    sPressed := 1
    CheckDirection()
return

~CapsLock & d::
    dPressed := 1
    CheckDirection()
return

; 检测按键释放
~CapsLock & w Up::
    wPressed := 0
    CheckDirection()
return

~CapsLock & a Up::
    aPressed := 0
    CheckDirection()
return

~CapsLock & s Up::
    sPressed := 0
    CheckDirection()
return

~CapsLock & d Up::
    dPressed := 0
    CheckDirection()
return


; 检查方向并移动鼠标
CheckDirection() {
    global wPressed, aPressed, sPressed, dPressed, MouseMoveDistance

    x := 0
    y := 0

    if (wPressed && aPressed) {
        x := -MouseMoveDistance
        y := -MouseMoveDistance
    } else if (wPressed && dPressed) {
        x := MouseMoveDistance
        y := -MouseMoveDistance
    } else if (sPressed && aPressed) {
        x := -MouseMoveDistance
        y := MouseMoveDistance
    } else if (sPressed && dPressed) {
        x := MouseMoveDistance
        y := MouseMoveDistance
    } else if (wPressed) {
        y := -MouseMoveDistance
    } else if (sPressed) {
        y := MouseMoveDistance
    } else if (aPressed) {
        x := -MouseMoveDistance
    } else if (dPressed) {
        x := MouseMoveDistance
    }

    if (x != 0 || y != 0) {
        MouseMove, %x%, %y%, 0, R
    }
}
