; 逐渐丰满的caps脚本
; 用win+caps切换caps状态

;#NoTrayIcon
#InputLevel 1
#Include %A_ScriptDir%\lowInputLevel.ahk
CapsLockState := "AlwaysOff"
SetCapsLockState, %CapsLockState%

; 直接将 Caps + 十个键映射为数字键
CapsLock & Delete::Send, 1
CapsLock & End::Send, 2
CapsLock & PgDn::Send, 3
CapsLock & Insert::Send, 4
CapsLock & Home::Send, 5
CapsLock & PgUp::Send, 6
CapsLock & PrintScreen::Send, 7
CapsLock & ScrollLock::Send, 8
CapsLock & Pause::Send, 9
CapsLock & Rctrl::Send, 0
CapsLock & Backspace::Send, 0

; Caps + 方向键映射为加减乘除运算符
CapsLock & Up::Send, {+}
CapsLock & =::Send, {+}
CapsLock & Down::Send, -
CapsLock & -::Send, -
CapsLock & Left::Send, *
CapsLock & Right::Send, /
CapsLock & \::Send, *+-*0
CapsLock & AppsKey::Send, .
; 直接将 Caps + 十个键映射为数字键
Rshift & Delete::Send, 1
Rshift & End::Send, 2
Rshift & PgDn::Send, 3
Rshift & Insert::Send, 4
Rshift & Home::Send, 5
Rshift & PgUp::Send, 6
Rshift & PrintScreen::Send, 7
Rshift & ScrollLock::Send, 8
Rshift & Pause::Send, 9
Rshift & Rctrl::Send, 0
Rshift & Backspace::Send, 0

; Caps + 方向键映射为加减乘除运算符
Rshift & Up::Send, {+}
Rshift & Down::Send, -
Rshift & -::Send, -
Rshift & Left::Send, *
Rshift & Right::Send, /
Rshift & \::Send, *
Rshift & AppsKey::Send, .

~`::  ; 按下 ` 键
    BlockInput, MouseMove  ; 禁止鼠标移动
    keyPressCount := 0  ; 初始化按键计数器

    ; 等待直到按下两个任意按键
    while (keyPressCount < 1)
    {
        Input, userInput, L1 T1  ; 等待用户输入一个字符（按键），并设置超时为1秒

        if (userInput)  ; 如果有按键输入
        {

			Send, %userInput%
            keyPressCount := keyPressCount + 1  ; 增加按键计数器
        }
    }

    BlockInput, MouseMoveOff  ; 解除鼠标禁用
return



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

CapsLock & w::
sendKeyWithModStates("Up")
return

CapsLock & s::
sendKeyWithModStates("Down")
return

CapsLock & a::
sendKeyWithModStates("Left")
return

CapsLock & d::
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


CapsLock & `::  ; 按下 CapsLock + 反引号时触发
SendL("``")
return



CapsLock & 3:: 
Send {End}
Send {Space 3}
return

CapsLock & 2::
Send ^t
Sleep 200
Send !{F2}  ; 发送 Alt+2
Sleep 500  ; 等待 100 毫秒
Send !p  ; 发送 Alt+p

return
   
CapsLock & r:: ;全屏,隐藏标题栏
  WinGetPos, X, Y, Width, Height, A

  WinSet, Style, ^0xC00000, A

  WinMove, A, , X, Y, Width, Height-1
  WinMove, A, , X, Y, Width, Height
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

CapsLock & .::
send,-
send,>
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

CapsLock & e::
send, {End}
send, {enter}
return



CapsLock & enter::
send, {end}
send, {:}
send, {enter}
return

#IfWinActive ahk_class Engine ; 监测 Godot 的类名

;~!q:: ;alt+q 切换焦点到文件系统 2025_03_19 03:37:06已经弃用 因为还是底部的文件系统好用一点 虽然还是很屎
;	send, {tab}
;	send, {tab}
;	send, {tab}
;return

!w:: ; Alt + w
    Send "{RButton}"  ; 发送鼠标右键
	Sleep, 1
    Send {Up}     ; 发送两次上方向键
	Send {Up}
	Sleep, 1
    Send "{Enter}"    ; 发送回车键
    ; 切换到名为 "Cursor" 的窗口
    WinActivate, ahk_exe Cursor.exe ; 替换 Cursor.exe 为实际目标窗口的进程名
return
return



!e:: ; Alt + e

    ; 切换到名为 "Cursor" 的窗口
    WinActivate, ahk_exe Cursor.exe ; 替换 Cursor.exe 为实际目标窗口的进程名
return

CapsLock & c::
    SendInput, ^+c
    ; 保存当前剪贴板内容
    ClipSaved := ClipboardAll
    
    
    ; 切换到场景树面板
    SendInput, ^1
    Sleep, 1  ; 等待1毫秒确保面板切换完成
    
    ; 切换到检查器面板
    SendInput, ^2
    Sleep, 1  ; 等待1毫秒确保面板切换完成
    
    ; 输入点号
    SendInput, .
    
    ; 粘贴之前复制的内容
    SendInput, ^v
    
Return

CapsLock & v::
     ; 切换到场景树面板
    SendInput, ^1
    Sleep, 1  ; 等待1毫秒确保面板切换完成
    
    ; 切换到检查器面板
    SendInput, ^2
    Sleep, 1  ; 等待1毫秒确保面板切换完成
    SendInput, .
    
    ; 粘贴之前复制的内容
    SendInput, ^v
    
Return

; 按下 win + F8 时，仅发送 F8
#F8::
{
	SendEvent {F8}

    return
}


; 按下 F8 时，发送 F12 并切换到 Cursor 窗口
~F8::
{

    IfWinExist, ahk_exe Cursor.exe
    {
        WinActivate  ; 激活 Cursor 窗口
    }
    return
}

CapsLock & p:: ;用来将免引号的检索后再用引号括起来(检索信号名称),或者说用来将内容双引号起来
Send, ^+{Left}
Send "
send, {right}
return

#If


#If WinActive("ahk_exe Cursor.exe")

F5:: ;Cursor中的f5切程序运行
{
	Send, ^s
	Sleep, 100
    ; 切换godot
    WinActivate, ahk_class Engine
    ; 等待一段时间以确保操作被注册
    Sleep, 150
    ; 发送 F5
    Send, {F5}
}
return

CapsLock & p::
Send, ^+{Left}
Send "
send, {right}
return

F6:: ;Cursor中的f6切程序运行
{
	Send, ^s
	Sleep, 100
    ;切换godot
	WinActivate, ahk_class Engine
    ; 等待一段时间以确保操作被注册
    Sleep, 150
    ; 发送 F6
    Send, {F6}
}
return
#If




CapsLock & v:: ; CapsLock+V
    ; 获取当前活动窗口的类名
    WinGetClass, className, A
    
    ; 检查当前窗口是否为 Excel
    if (className = "XLMAIN") {
        ; 发送 Alt+E
        Send !e
        
        ; 等待一点时间，确保 Alt+E 被处理
        Sleep 50
        
        ; 发送 S 和 T，然后回车
        Send st{Enter}
		;Sleep 50
		;Send {esc}
    }
	;aseprite中输入中文
	IfWinActive, ahk_exe aseprite.exe
    {
        ; 弹出输入框，获取用户输入
        InputBox, userInput,输入, , , 200, 100
        
        ; 检查用户是否点击了取消
        if ErrorLevel
            return  ; 如果取消输入，直接退出
        
        ; 将用户输入的内容复制到剪贴板
        Clipboard := userInput
        Send ^v
    }
return

~^A::  ;在aseprite中全选后自动切换到选择方便像素移动
	IfWinActive, ahk_exe aseprite.exe
{
    Sleep 100  ; 等待 100 毫秒
    Send q   ; 发送 Q
}
return



CapsLock & c::
{
    if WinActive("ahk_class XLMAIN")  ; 确保当前窗口是 Excel
    {
        Send {F2}        ; 发送 F2 进入单元格编辑模式
        Sleep 100        ; 等待 10 毫秒
        Send ^a          ; 发送 Ctrl+A 选择全部内容
        Sleep 100        ; 等待 10 毫秒
        Send ^c          ; 发送 Ctrl+C 复制
        Sleep 100        ; 等待 10 毫秒
        Send {Esc}       ; 发送 Esc 退出编辑模式
    }
    return
}

CapsLock & Lshift::  ; 监听 CapsLock + 左Shift
{	
	Send, ^!{Numpad1}
     ; 按下右 Shift
    DllCall("user32.dll\keybd_event", "UInt", 0xA1, "UInt", 0, "UInt", 0, "UInt", 0)  ; Right Shift Down

    ; 等待片刻，模拟按键按住的效果
    Sleep 10

    ; 释放右 Shift
    DllCall("user32.dll\keybd_event", "UInt", 0xA1, "UInt", 0, "UInt", 2, "UInt", 0)  ; Right Shift Up


    return

}




;输入时间到剪切板
CapsLock & T::
    Clipboard := A_YYYY "_" A_MM "_" A_DD " " A_Hour ":" A_Min ":" A_Sec
    Send ^v  ; 发送粘贴命令（Ctrl + V）
return

;静音部分开始


#Include %A_ScriptDir%\VA.ahk ; 引入 VA.ahk 库,用来静音当前活动窗口

CapsLock & F1:: ;caps+* hotkey - toggle mute state of active window
  WindowEXE := WinExist("A")
    ControlGetFocus, FocusedControl, ahk_id %WindowEXE%
    ControlGet, Hwnd, Hwnd,, %FocusedControl%, ahk_id %WindowEXE%
    WinGet, simplexe, processname, ahk_id %Hwnd%
  Loop, 3  ; 最多重试3次
  {
    if (Volume := GetVolumeObject(simplexe))
    {
      VA_ISimpleAudioVolume_GetMute(Volume, Mute)
      VA_ISimpleAudioVolume_SetMute(Volume, !Mute)
      ObjRelease(Volume)
      return
    }
    Sleep, 1000  ; 等待100ms后重试
  }
return

GetVolumeObject(targetExeName) {
    static IID_IASM2 := "{77AA99A0-1BD6-484F-8BC7-2C654C9A9B6F}"
    , IID_IASC2 := "{bfb7ff88-7239-4fc9-8fa2-07c950be9c6d}"
    , IID_ISAV := "{87CE5498-68D6-44E5-9215-6DA47EF883D8}"

    ; Get all audio devices
    Loop, 10 ; Change the loop limit based on the number of audio devices you have
    {
        DAE := VA_GetDevice(A_Index)
        if (DAE)
        {
            ; Check if the device is active and a rendering endpoint
            VA_IMMDevice_GetState(DAE, State)
            VA_IConnector_GetDataFlow(DAE, DataFlow)

            if (State == 1 && DataFlow == 0)  ; Check if the device is active and rendering
            {
                ; Activate the session manager
                VA_IMMDevice_Activate(DAE, IID_IASM2, 0, 0, IASM2)

                ; Enumerate sessions for the current device
                VA_IAudioSessionManager2_GetSessionEnumerator(IASM2, IASE)
                VA_IAudioSessionEnumerator_GetCount(IASE, Count)

                ; Search for an audio session with the required name for the current device
                Loop, % Count
                {
                    VA_IAudioSessionEnumerator_GetSession(IASE, A_Index-1, IASC)
                    IASC2 := ComObjQuery(IASC, IID_IASC2)

                    ; If IAudioSessionControl2 is queried successfully
                    if (IASC2)
                    {
                        VA_IAudioSessionControl2_GetProcessID(IASC2, SPID)
                        ProcessNameFromPID := GetProcessNameFromPID(SPID)

                        ; If the process name matches the one we are looking for
                        if (ProcessNameFromPID == targetExeName)
                        {
                            ; Check if the session is active before retrieving volume interface
                            VA_IAudioSessionControl_GetState(IASC2, SessionState)
                            if (SessionState == 1) ; AudioSessionStateActive
                            {
                                ISAV := ComObjQuery(IASC2, IID_ISAV)
                                if (ISAV)
                                {
                                    return ISAV ;
                                }
                                else
                                {
                                    return
                                }
                            }
                            ObjRelease(IASC2)
                        }

                        ObjRelease(IASC2)
                    }

                    ObjRelease(IASC)
                }
            }

            ObjRelease(IASE)
            ObjRelease(IASM2)
            ObjRelease(DAE)
        }
    }

    ; MsgBox No active audio session found for the specified process: %targetExeName%
    return ; Return 0 if there's an issue retrieving the interface
}

GetProcessNameFromPID(PID)
{
    hProcess := DllCall("OpenProcess", "UInt", 0x0400 | 0x0010, "Int", false, "UInt", PID)
    VarSetCapacity(ExeName, 260, 0)
    DllCall("Psapi.dll\GetModuleFileNameEx", "UInt", hProcess, "UInt", 0, "Str", ExeName, "UInt", 260)
    DllCall("CloseHandle", "UInt", hProcess)
    return SubStr(ExeName, InStr(ExeName, "\", false, -1) + 1)
}

RemoveToolTip:
    ToolTip ; Remove the tooltip
    SetTimer, RemoveToolTip, Off ; Turn off the timer
    return


;
; ISimpleAudioVolume : {87CE5498-68D6-44E5-9215-6DA47EF883D8}
;
VA_ISimpleAudioVolume_SetMasterVolume(this, ByRef fLevel, GuidEventContext="") {
    return DllCall(NumGet(NumGet(this+0)+3*A_PtrSize), "ptr", this, "float", fLevel, "ptr", VA_GUID(GuidEventContext))
}
VA_ISimpleAudioVolume_GetMasterVolume(this, ByRef fLevel) {
    return DllCall(NumGet(NumGet(this+0)+4*A_PtrSize), "ptr", this, "float*", fLevel)
}
VA_ISimpleAudioVolume_SetMute(this, ByRef Muted, GuidEventContext="") {
    return DllCall(NumGet(NumGet(this+0)+5*A_PtrSize), "ptr", this, "int", Muted, "ptr", VA_GUID(GuidEventContext))
}
VA_ISimpleAudioVolume_GetMute(this, ByRef Muted) {
    return DllCall(NumGet(NumGet(this+0)+6*A_PtrSize), "ptr", this, "int*", Muted)
}
 ;静音部分结束





; Toggle CapsLock functionality with win + CapsLock
#CapsLock::
CapsLockState := (CapsLockState = "AlwaysOff") ? "AlwaysOn" : "AlwaysOff"
SetCapsLockState, %CapsLockState%
return






 
