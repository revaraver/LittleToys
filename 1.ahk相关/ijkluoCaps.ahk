; 逐渐丰满的caps脚本
; 用win+caps切换caps状态

;#NoTrayIcon
#InputLevel 1
#Include %A_ScriptDir%\lowInputLevel.ahk
CoordMode, mouse, Screen
CoordMode, ToolTip, Screen
toggleswitch:=0
togglewacom:=0
toggled:=0
CapsLockState := "AlwaysOff"
SetCapsLockState, %CapsLockState%
MouseGetPos, xposr, yposr
ToolTip caps脚本启动,1920,1000
sleep 300 
ToolTip
global LastBackspaceTime := 0
global LastDeleteTime := 0
global DebounceDelay :=70 ; 50ms debounce time
global BackspaceUpTime :=0
global BackdeleteUpTime :=0


; 检测系统从睡眠唤醒
OnMessage(0x218, "OnPowerEvent") ; WM_POWERBROADCAST 消息
OnPowerEvent(wParam, lParam) {
    if (wParam = 7) { ; PBT_APMRESUMESUSPEND (系统从睡眠唤醒)
        global toggleswitch, toggled, xposr, yposr
        toggleswitch := 0    
        toggled := 0
        xposr := 0
        yposr := 0
        ToolTip, 脚本已重置状态, 1920, 1000
        SetTimer, RemoveToolTip, -2000
		Send, {Ctrl up}  ; 模拟松开 Ctrl 键
		Send, {Alt up}   ; 模拟松开 Alt 键
		Send, {Shift up} ; 模拟松开 Shift 键
    }
    return 0
}
RemoveToolTip:
    ToolTip
return

; 使用 $ 前缀防止 Send ^q 再次触发此热键本身, 关闭软件用
$^q::
    ; 注意：列表中的逗号后千万不要加空格
    ProcessList := "notepad.exe,WindowsTerminal.exe,cmd.exe,powershell.exe"   
    ; 获取当前活动窗口的进程名
    WinGet, activeProcess, ProcessName, A
	WinGet, activeID, ID, A  ; 获取当前窗口的唯一 ID (HWND)，关闭时更精准
    ; 检查当前进程名是否在列表中（注意：ProcessList两侧不要加%）
	; tooltip,%activeProcess%
    if activeProcess in %ProcessList%
    {
        WinKill, ahk_id %activeID%
    }
    else 
    {
        ; 使用 SendLevel 或 $ 前缀确保这里发出的 ^q 不会重新触发脚本
        Send, ^q
    }
return







;chrome的左右键一起按是关闭标签
#IfWinActive ahk_exe chrome.exe
; 当按住右键时，按下中键（MButton）执行关闭标签页指令
RButton & MButton::
    Send ^{w} ; 发送 Ctrl+W 关闭标签页
    return
	
RButton & LButton::
    Send ^{w} ; 发送 Ctrl+W 关闭标签页
    return
	
; 右键 + 滚轮上：切换上一个标签
RButton & WheelUp::Send ^+{Tab}

; 右键 + 滚轮下：切换下一个标签
RButton & WheelDown::Send ^{Tab}

RButton::
    Send {RButton}
    return
#IfWinActive

; === Directory Opus 设置 ===
#IfWinActive ahk_exe dopus.exe
; 右键 + 中键/左键：关闭当前标签 (Opus 默认关闭标签是 Ctrl+F4 或 Ctrl+W)
RButton & MButton::Send ^{w}
RButton & LButton::Send ^{w}

; 右键 + 滚轮上：切换到上一个标签
RButton & WheelUp::Send ^{PgUp}

; 右键 + 滚轮下：切换到下一个标签
RButton & WheelDown::Send ^{PgDn}

; 必须重复定义 RButton 释放逻辑，否则右键点击会失效
RButton::Send {RButton}
#IfWinActive

~F13::
    Send, {Space}
return

F14::`

!`::
WinMinimize, A

return

; Variables to track last key press time


; Backspace key handler

;#已经用530洗好了
/*
$Backspace Up::
	if (A_TickCount - BackspaceUpTime < DebounceDelay)
        return
    BackspaceUpTime := A_TickCount
return


$Backspace::
    CurrentTime := A_TickCount
    ; 去抖处理：忽略短时间内重复触发
    if (CurrentTime - BackspaceUpTime < DebounceDelay)
        return

    ; 记录当前时间
    ;LastBackspaceTime := CurrentTime

    ; 发送单次 Backspace
    Send {Backspace}

    ; 检查是否持续按住
    KeyWait, Backspace, T0.5  ; 等待 500ms 判断是否
    if ErrorLevel  ; 如果仍在按住（ErrorLevel = 1）
    {
        ; 进入长按模送 Backspace
        while GetKeyState("Backspace", "P")
        {
            Send {Backspace}
            Sleep 31  ; 控制连续删除）
        }
    }
return

; Delete key handler

$Delete Up::
    BackdeleteUpTime := A_TickCount
return

$Delete::
    CurrentTime := A_TickCount
    ; 去抖处理：忽略短时间内重复触发
    if (CurrentTime - BackdeleteUpTime < DebounceDelay)
        return

    ; 记录当前时间
    ;LastDeleteTime := CurrentTime

    ; 发送单次 Delete
    Send {Delete}

    ; 检查是否持续按住
    KeyWait, Delete, T0.5  ; 等待 500ms 判断是否松
    if ErrorLevel  ; 如果仍在按住（ErrorLevel = 1）
    {
        ; 进入长按模式，持续发送 Delete
        while GetKeyState("Delete", "P")
        {
            Send {Delete}
            Sleep 31  ; 控制连续删除速度（可调整）
        }
    }
return
*/
CapsLock & ESC::
    ExitApp
return

CapsLock & F1::
    reload
return

Capslock & F12::
    Run, "E:\sugarlose\github\LittleToys\1.ahk相关\gemini_api_updater.ahk" ; !!重要!! 请务必将这里的路径修改为你实际保存 gemini_api_updater.ahk 的路径
Return

CapsLock & F3::
	KeyWait, F3,U  ; 等待 F3 抬起
    KeyWait, CapsLock,U  ; 等待 CapsLock 抬起
	Sleep 100
	Send ^!{F1}         ; Ctrl+Alt+F1
    Sleep 300           ; 稍作延迟以确保系统反应

 /*   Send #x             ; Win+X
    Sleep 300

    Send u              ; U 进入关机菜单
    Sleep 200

    Send s              ; S 选择休眠/睡眠（取决于系统配置）
*/
	; --- 核心：直接调用系统睡眠/休眠 ---
    ; DllCall 参数解释: (是否进入休眠, 是否立即强制, 是否挂起所有唤醒事件)
    
    ; 如果你想执行【普通睡眠 (S3)】：
    DllCall("PowrProf\SetSuspendState", "Int", 0, "Int", 0, "Int", 0)
    
    ; 如果你想执行【休眠 (S4)】：
    ; DllCall("PowrProf\SetSuspendState", "Int", 1, "Int", 0, "Int", 0)

    ; 注意：因为电脑已经睡了，脚本会在这里“暂停”
    ; 直到你下次唤醒电脑，它才会继续执行下面的代码

    Send ^!{F2}         ; Ctrl+Alt+F2
	return

CapsLock & F4::
	KeyWait, F4,U  ; 等待 F4 抬起
    KeyWait, CapsLock,U  ; 等待 CapsLock 抬起
	Sleep 100
	Send ^!{F1}         ; Ctrl+Alt+F1
    Sleep 300           ; 稍作延迟以确保系统反应

    Send #x             ; Win+X
    Sleep 300

    Send u              ; U 进入关机菜单
    Sleep 200

    Send s              ; S 选择休眠/睡眠（取决于系统配置）
    ;Sleep 1000          ; 等待操作完成或取消（视情况）

    Send ^!{F2}         ; Ctrl+Alt+F2:
	Sleep 200
	
	Send #x             ; Win+X
    Sleep 300

    Send u              ; U 进入关机菜单
    Sleep 200

    Send s              ; S 选择休眠/睡眠（取决于系统配置）
	return

;用来改无界鼠标的  2025_06_29 21:13:58
CapsLock & Alt::
{
	if(toggleswitch)
	{
		Click down  ; 模拟鼠标按下
		KeyWait, Alt  ; 等待空格键松开
		Click up  ; 松开鼠标 
		
	}
	return
}


CapsLock & Space::
	if GetKeyState("Ctrl", "P")
 	{
        toggleswitch:=!toggleswitch
		
		if(togglewacom)
		{
			toggleswitch:=1
			togglewacom:=0
		}
		ToolTip % "caps+space切换" (toggleswitch? "开" : "关")
		sleep 500 
		ToolTip
		Send, {Ctrl up}  ; 模拟松开 Ctrl 键
		Send, {Alt up}   ; 模拟松开 Alt 键
		Send, {Shift up} ; 模拟松开 Shift 键
		
		
		return
    }

	else
	{
		if(toggleswitch)
		{	
			global xposr, yposr
			WinGet, currentProcess, ProcessName, A

			MouseGetPos, xpos, ypos
			;ToolTip % xpos "," ypos currentProcess , 1920 , 1000
			
			;sleep 500 
		    ;ToolTip
			;if (currentProcess = "PowerToys.MouseWithoutBordersHelper.exe")
			;if ((xpos=1920 && ypos=4)||currentProcess = "PowerToys.MouseWithoutBordersHelper.exe")
			if ((xpos=1920 && ypos=1080)||currentProcess = "PowerToys.MouseWithoutBordersHelper.exe")
			{
				ScreenSwitch("toRight")
				Send, {CapsLock up}
			}
			else
			{	
				MouseGetPos, xposr, yposr
				ScreenSwitch("toLeft")
				Send, {CapsLock up}
			}
			
		}
		else
		{
			    Click down  ; 模拟鼠标按下
				KeyWait, Space  ; 等待空格键松开
				Click up  ; 松开鼠标 
		}
	}
	
return


	
ScreenSwitch(f){

	if(f="toLeft")
	{
		Send ^!{F1}   ; 发送 Ctrl+Alt+F1
		
		
		toggled:=1
		MouseMove, 1, 0, 0, R  ; 向右移动 1 像素,激活左屏焦点
		if(togglewacom)
		{
			;click
		}
		prints("左")
		return
		
	}
	if(f="toRight")
	{
		Send ^!{F2}   ; 发送 Ctrl+Alt+F2 
		MouseMove, %xposr%, %yposr%, 0  ; 0 表示瞬间移动
		toggled:=0
		prints("右")
		return
	}

		
			
	;Send, {Ctrl up}  ; 模拟松开 Ctrl 键
	;Send, {Alt up}   ; 模拟松开 Alt 键
	;Send, {Shift up} ; 模拟松开 Shift 键
	;Send, {CapsLock up}
	return
}     





prints(text) {
    ToolTip, %text%,1920,1000
    sleep,500
	ToolTip
	return
}






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
;CapsLock & Backspace::Send, 0

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
;Rshift & -::Send, -
;Rshift & Left::Send, *
;Rshift & Right::Send, /
Rshift & \::Send, *
Rshift & AppsKey::Send, .

/*
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
*/


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
    SendInput, %ModStates%{%Key%}
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

;为了防止颜色误报挪到最下面了
CapsLock & '::	 ;'
sendKeyWithModStates("Delete")
return


CapsLock & `::  ; 按下 CapsLock + 反引号时触发
SendL("``")
return



CapsLock & 3:: 
Send {End}
SendInput {Space 3}
return

CapsLock & 2::
Send {enter}

return

CapsLock & 1::
Send {esc}

return
   
CapsLock & f11:: ;全屏,隐藏标题栏
  WinGetPos, X, Y, Width, Height, A

  WinSet, Style, ^0xC00000, A

  WinMove, A, , X, Y, Width, Height-1
  WinMove, A, , X, Y, Width, Height
  return


CapsLock & f::(



CapsLock & h::)
return

CapsLock & b::+
return

CapsLock & n::_
return

CapsLock & m::=
return

CapsLock & ,::
send, {End}
send, {,}
send, {enter}
return

CapsLock & .::
send,-
send,>
return




;CapsLock & [::^z
;return

;CapsLock & ]::^+z
;return





CapsLock & q::
    if WinActive("ahk_exe notepad++.exe")
    {
        Send, ^q
    }
    else
    {
        Send, ^/
    }
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

/*
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
*/
return

!.::
	send,>=
	return

!,::
	send,<=
	return

!/::
	send,/=
	return

!8::
	send,*=
	return

!-::
	send,-=
	return

!=::
	send,{+}
	send,=
	return
	
!;::
send, {End}
send, :
send, {enter}
return

/*
!e:: ; Alt + e

    ; 切换到名为 "Cursor" 的窗口
    WinActivate, ahk_exe Cursor.exe ; 替换 Cursor.exe 为实际目标窗口的进程名
return
*/

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

CapsLock & [:: ;用来将免引号的检索后再用引号括起来(检索信号名称),或者说用来将内容双引号起来
Send, ^+{Left}
Send, " ;"
Send, {right}
return

CapsLock & r::
	Clipboard := ""
    Send, ^c  ; 复制选中的文本
    ClipWait, 10  ; 等待剪贴板更新
    var := Trim(Clipboard)  ; 获取选中的内容并去掉前后空格
	
    ; ----------------------------------------------------
    ; 【最小化修改】
    ; 1. 创建一个副本，专门用于字符串显示
    display_var := var
    ; 2. 只对这个副本进行净化处理
    StringReplace, display_var, display_var, ", \", All
    ; ----------------------------------------------------
    
    ; 在拼接时，字符串部分用 display_var，参数部分用原始的 var
    Clipboard := "print(""<%s>[%s]:" . display_var . "是%s"" %[Engine.get_frames_drawn(),self.name," . var . "])"
	
	ClipWait, 10
    ; 可选：显示构建后的字符串
    ;ToolTip, %Clipboard%
	ToolTip, 已复制%Clipboard%
	sleep, 500
	ToolTip
    return



#IfWinActive


#If WinActive("ahk_exe Cursor.exe")

CapsLock & r::
	Clipboard := ""
    Send, ^c  ; 复制选中的文本
    ClipWait, 10  ; 等待剪贴板更新
    var := Trim(Clipboard)  ; 获取选中的内容并去掉前后空格
	
    ; 拼接 Python 风格的 print("var是%" %var)
    Clipboard := "print(""<%s>[%s]:" . var . "是%s"" %[Engine.get_frames_drawn(),self.name," . var . "])"  ;print("var是%s" %var)
	ClipWait, 10
    ; 可选：显示构建后的字符串
    ;ToolTip, %Clipboard%
	ToolTip, 已复制%Clipboard%
	sleep, 500
	ToolTip
    return

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
Send " ;"
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
#IfWinActive


#If WinActive("ahk_exe Antigravity.exe")

CapsLock & r::
	Clipboard := ""
    Send, ^c  ; 复制选中的文本
    ClipWait, 10  ; 等待剪贴板更新
    var := Trim(Clipboard)  ; 获取选中的内容并去掉前后空格
	
    ; 拼接 Python 风格的 print("var是%" %var)
    Clipboard := "print(""<%s>[%s]:" . var . "是%s"" %[Engine.get_frames_drawn(),self.name," . var . "])"  ;print("var是%s" %var)
	ClipWait, 10
    ; 可选：显示构建后的字符串
    ;ToolTip, %Clipboard%
	ToolTip, 已复制%Clipboard%
	sleep, 500
	ToolTip
    return

F5:: ;Antigravity 中的f5切程序运行
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
Send, " ; "
Send, {right}
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
#IfWinActive

#v::
        ; 弹出输入框，获取用户输入
        InputBox, userInput,输入, , , 200, 100
        
        ; 检查用户是否点击了取消
        if ErrorLevel
            return  ; 如果取消输入，直接退出
        
        ; 将用户输入的内容复制到剪贴板
        Clipboard := userInput
        Send ^v
		return


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
		IfWinActive, ahk_exe blender.exe
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
    Sleep 1

    ; 释放右 Shift
    DllCall("user32.dll\keybd_event", "UInt", 0xA1, "UInt", 0, "UInt", 2, "UInt", 0)  ; Right Shift Up


    return

}




;输入时间到剪切板
CapsLock & T::
    Clipboard := A_YYYY "_" A_MM "_" A_DD " " A_Hour ":" A_Min ":" A_Sec
    Send ^v  ; 发送粘贴命令（Ctrl + V）
return

/*
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
;注释掉了
*/



; Toggle CapsLock functionality with win + CapsLock
#CapsLock::
CapsLockState := (CapsLockState = "AlwaysOff") ? "AlwaysOn" : "AlwaysOff"
SetCapsLockState, %CapsLockState%
return






 