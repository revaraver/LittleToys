; AutoHotkey script to disable capslock and make capslock+ijkl behave like arrow keys (ish),
; and implement capslock toggling functionality with Shift + CapsLock.

#NoTrayIcon

CapsLockState := "AlwaysOff"
SetCapsLockState, %CapsLockState%
MouseMoveDistance := 70  ; 定义鼠标移动距离变量
#MouseMoveDistanceS := 300  ; 定义鼠标移动距离变量

getModStates()
{
    ModState := ""
    if GetKeyState("Shift", "D")
    {
        ModState .= "+" 
    }
    if GetKeyState("Ctrl", "D")
    {
        ModState .= "^"
    }
    if GetKeyState("Alt", "D")
    {
        ModState .= "!"
    }
    if GetKeyState("LWin", "D") || GetKeyState("RWin", "D")
    {
        ModState .= "#"
    }
    return ModState
}






sendKeyWithModStates(Key)
{
    ModStates := getModStates()
    Send, %ModStates%{%Key%}
    return
}

CapsLock & i::
sendKeyWithModStates("Up")
return

CapsLock & k::
sendKeyWithModStates("Down")
return

CapsLock & j::
sendKeyWithModStates("Left")
return

CapsLock & l::
sendKeyWithModStates("Right")
return

CapsLock & u::
sendKeyWithModStates("Home")
return

CapsLock & o::
sendKeyWithModStates("End")
return

CapsLock & `;::
sendKeyWithModStates("Backspace")
return

CapsLock & '::
sendKeyWithModStates("Delete")
return
   



CapsLock & f::(



CapsLock & h::)
return


CapsLock & n::_
return

CapsLock & m::+
return

CapsLock & ,::-
return

CapsLock & .::=
return

CapsLock & /::|
return 


CapsLock & [::^z
return

CapsLock & ]::^+z
return

CapsLock & Space::
click
return



CapsLock & q::
^/
return




;输入时间到剪切板
CapsLock & T::
    Clipboard := A_YYYY "_" A_MM "_" A_DD " " A_Hour ":" A_Min ":" A_Sec
    Send ^v  ; 发送粘贴命令（Ctrl + V）
return


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


; Toggle CapsLock functionality with Shift + CapsLock
#CapsLock::
CapsLockState := (CapsLockState = "AlwaysOff") ? "AlwaysOn" : "AlwaysOff"
SetCapsLockState, %CapsLockState%
return






 
