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

CapsLock & SC027::
sendKeyWithModStates("Backspace")
return

CapsLock & SC028::
sendKeyWithModStates("Delete")
return
   

;编辑器特别事件,解决godot4.3的与谷歌拼音冲突
CapsLock & f::
    ; 如果当前活动窗口是 Godot 编辑器
    if WinActive("ahk_class Engine")
    {
        SendPlay, (
    }
    else
    {
        Send, (
    }
return

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


;编辑器特别事件,解决godot4的与谷歌拼音冲突
#if WinActive("ahk_class Engine")

	
    Shift & 1::
        ClipSaved := ClipboardAll
        Clipboard := "!"  ; 将感叹号写入剪贴板
        Send, ^v  ; 发送 Ctrl + V 粘贴剪贴板内容
        Clipboard := ClipSaved
    return

    Shift & 3::
        ClipSaved := ClipboardAll
        Clipboard := "#"  ; 将井号写入剪贴板
        Send, ^v  ; 发送 Ctrl + V 粘贴剪贴板内容
        Clipboard := ClipSaved
    return

    Shift & 4::
        ClipSaved := ClipboardAll
        Clipboard := "$"  ; 将美元符号写入剪贴板
        Send, ^v  ; 发送 Ctrl + V 粘贴剪贴板内容
        Clipboard := ClipSaved
    return

    Shift & 5::
        ClipSaved := ClipboardAll
        Clipboard := "%"  ; 将百分号写入剪贴板
        Send, ^v  ; 发送 Ctrl + V 粘贴剪贴板内容
        Clipboard := ClipSaved
    return

    Shift & 7::
        ClipSaved := ClipboardAll
        Clipboard := "&"  ; 将&号写入剪贴板
        Send, ^v  ; 发送 Ctrl + V 粘贴剪贴板内容
        Clipboard := ClipSaved
    return

    Shift & 9::
        ClipSaved := ClipboardAll
        Clipboard := "("  ; 将左括号写入剪贴板
        Send, ^v  ; 发送 Ctrl + V 粘贴剪贴板内容
        Clipboard := ")"
        Send, ^v  ; 发送 Ctrl + V 粘贴剪贴板内容
        Send, {Left}
        Clipboard := ClipSaved
    return

    Shift & .::
        ClipSaved := ClipboardAll
        Clipboard := ">"  ; 将大于号写入剪贴板
        Send, ^v  ; 发送 Ctrl + V 粘贴剪贴板内容
        Clipboard := ClipSaved
    return

    '::  ; 单引号
        ClipSaved := ClipboardAll
        Clipboard := "'"  ; 将单引号写入剪贴板
        Send, ^v  ; 发送 Ctrl + V 粘贴剪贴板内容
        Clipboard := ClipSaved
    return

    "::  ; 双引号
        ClipSaved := ClipboardAll
        Clipboard := """"""  ; 将双引号写入剪贴板
        Send, ^v  ; 发送 Ctrl + V 粘贴剪贴板内容
        Send, {Left}
        Clipboard := ClipSaved
    return

    .::  ; 点号
        ClipSaved := ClipboardAll
        Clipboard := "."  ; 将点号写入剪贴板
        Send, ^v  ; 发送 Ctrl + V 粘贴剪贴板内容
        Clipboard := ClipSaved
    return

    NumpadDot::
        ClipSaved := ClipboardAll
        Clipboard := "."  ; 将点号写入剪贴板
        Send, ^v  ; 发送 Ctrl + V 粘贴剪贴板内容
        Clipboard := ClipSaved
    return

    -::
        ClipSaved := ClipboardAll
        Clipboard := "-"  ; 将小于号写入剪贴板
        Send, ^v  ; 发送 Ctrl + V 粘贴剪贴板内容
        Clipboard := ClipSaved
    return

    NumpadSub::
        ClipSaved := ClipboardAll
        Clipboard := "-"  ; 将小于号写入剪贴板
        Send, ^v  ; 发送 Ctrl + V 粘贴剪贴板内容
        Clipboard := ClipSaved
    return
	
	Shift & NumpadSub::
        ClipSaved := ClipboardAll
        Clipboard := "-"  ; 将小于号写入剪贴板
        Send, ^v  ; 发送 Ctrl + V 粘贴剪贴板内容
        Clipboard := ClipSaved
    return

    NumpadAdd::
        ClipSaved := ClipboardAll
        Clipboard := "+"  ; 将加号写入剪贴板
        Send, ^v  ; 发送 Ctrl + V 粘贴剪贴板内容
        Clipboard := ClipSaved
    return
	

#if

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






 
