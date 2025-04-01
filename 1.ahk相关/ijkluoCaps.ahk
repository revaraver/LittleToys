; �𽥷�����caps�ű�
; ��win+caps�л�caps״̬

;#NoTrayIcon
#InputLevel 1
#Include %A_ScriptDir%\lowInputLevel.ahk
CapsLockState := "AlwaysOff"
SetCapsLockState, %CapsLockState%

; ֱ�ӽ� Caps + ʮ����ӳ��Ϊ���ּ�
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

; Caps + �����ӳ��Ϊ�Ӽ��˳������
CapsLock & Up::Send, {+}
CapsLock & =::Send, {+}
CapsLock & Down::Send, -
CapsLock & -::Send, -
CapsLock & Left::Send, *
CapsLock & Right::Send, /
CapsLock & \::Send, *+-*0
CapsLock & AppsKey::Send, .
; ֱ�ӽ� Caps + ʮ����ӳ��Ϊ���ּ�
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

; Caps + �����ӳ��Ϊ�Ӽ��˳������
Rshift & Up::Send, {+}
Rshift & Down::Send, -
Rshift & -::Send, -
Rshift & Left::Send, *
Rshift & Right::Send, /
Rshift & \::Send, *
Rshift & AppsKey::Send, .

~`::  ; ���� ` ��
    BlockInput, MouseMove  ; ��ֹ����ƶ�
    keyPressCount := 0  ; ��ʼ������������

    ; �ȴ�ֱ�������������ⰴ��
    while (keyPressCount < 1)
    {
        Input, userInput, L1 T1  ; �ȴ��û�����һ���ַ����������������ó�ʱΪ1��

        if (userInput)  ; ����а�������
        {

			Send, %userInput%
            keyPressCount := keyPressCount + 1  ; ���Ӱ���������
        }
    }

    BlockInput, MouseMoveOff  ; ���������
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


CapsLock & `::  ; ���� CapsLock + ������ʱ����
SendL("``")
return



CapsLock & 3:: 
Send {End}
Send {Space 3}
return

CapsLock & 2::
Send ^t
Sleep 200
Send !{F2}  ; ���� Alt+2
Sleep 500  ; �ȴ� 100 ����
Send !p  ; ���� Alt+p

return
   
CapsLock & r:: ;ȫ��,���ر�����
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

#IfWinActive ahk_class Engine ; ��� Godot ������

;~!q:: ;alt+q �л����㵽�ļ�ϵͳ 2025_03_19 03:37:06�Ѿ����� ��Ϊ���ǵײ����ļ�ϵͳ����һ�� ��Ȼ���Ǻ�ʺ
;	send, {tab}
;	send, {tab}
;	send, {tab}
;return

!w:: ; Alt + w
    Send "{RButton}"  ; ��������Ҽ�
	Sleep, 1
    Send {Up}     ; ���������Ϸ����
	Send {Up}
	Sleep, 1
    Send "{Enter}"    ; ���ͻس���
    ; �л�����Ϊ "Cursor" �Ĵ���
    WinActivate, ahk_exe Cursor.exe ; �滻 Cursor.exe Ϊʵ��Ŀ�괰�ڵĽ�����
return
return



!e:: ; Alt + e

    ; �л�����Ϊ "Cursor" �Ĵ���
    WinActivate, ahk_exe Cursor.exe ; �滻 Cursor.exe Ϊʵ��Ŀ�괰�ڵĽ�����
return

CapsLock & c::
    SendInput, ^+c
    ; ���浱ǰ����������
    ClipSaved := ClipboardAll
    
    
    ; �л������������
    SendInput, ^1
    Sleep, 1  ; �ȴ�1����ȷ������л����
    
    ; �л�����������
    SendInput, ^2
    Sleep, 1  ; �ȴ�1����ȷ������л����
    
    ; ������
    SendInput, .
    
    ; ճ��֮ǰ���Ƶ�����
    SendInput, ^v
    
Return

CapsLock & v::
     ; �л������������
    SendInput, ^1
    Sleep, 1  ; �ȴ�1����ȷ������л����
    
    ; �л�����������
    SendInput, ^2
    Sleep, 1  ; �ȴ�1����ȷ������л����
    SendInput, .
    
    ; ճ��֮ǰ���Ƶ�����
    SendInput, ^v
    
Return

; ���� win + F8 ʱ�������� F8
#F8::
{
	SendEvent {F8}

    return
}


; ���� F8 ʱ������ F12 ���л��� Cursor ����
~F8::
{

    IfWinExist, ahk_exe Cursor.exe
    {
        WinActivate  ; ���� Cursor ����
    }
    return
}

CapsLock & p:: ;�����������ŵļ�������������������(�����ź�����),����˵����������˫��������
Send, ^+{Left}
Send "
send, {right}
return

#If


#If WinActive("ahk_exe Cursor.exe")

F5:: ;Cursor�е�f5�г�������
{
	Send, ^s
	Sleep, 100
    ; �л�godot
    WinActivate, ahk_class Engine
    ; �ȴ�һ��ʱ����ȷ��������ע��
    Sleep, 150
    ; ���� F5
    Send, {F5}
}
return

CapsLock & p::
Send, ^+{Left}
Send "
send, {right}
return

F6:: ;Cursor�е�f6�г�������
{
	Send, ^s
	Sleep, 100
    ;�л�godot
	WinActivate, ahk_class Engine
    ; �ȴ�һ��ʱ����ȷ��������ע��
    Sleep, 150
    ; ���� F6
    Send, {F6}
}
return
#If




CapsLock & v:: ; CapsLock+V
    ; ��ȡ��ǰ����ڵ�����
    WinGetClass, className, A
    
    ; ��鵱ǰ�����Ƿ�Ϊ Excel
    if (className = "XLMAIN") {
        ; ���� Alt+E
        Send !e
        
        ; �ȴ�һ��ʱ�䣬ȷ�� Alt+E ������
        Sleep 50
        
        ; ���� S �� T��Ȼ��س�
        Send st{Enter}
		;Sleep 50
		;Send {esc}
    }
	;aseprite����������
	IfWinActive, ahk_exe aseprite.exe
    {
        ; ��������򣬻�ȡ�û�����
        InputBox, userInput,����, , , 200, 100
        
        ; ����û��Ƿ�����ȡ��
        if ErrorLevel
            return  ; ���ȡ�����룬ֱ���˳�
        
        ; ���û���������ݸ��Ƶ�������
        Clipboard := userInput
        Send ^v
    }
return

~^A::  ;��aseprite��ȫѡ���Զ��л���ѡ�񷽱������ƶ�
	IfWinActive, ahk_exe aseprite.exe
{
    Sleep 100  ; �ȴ� 100 ����
    Send q   ; ���� Q
}
return



CapsLock & c::
{
    if WinActive("ahk_class XLMAIN")  ; ȷ����ǰ������ Excel
    {
        Send {F2}        ; ���� F2 ���뵥Ԫ��༭ģʽ
        Sleep 100        ; �ȴ� 10 ����
        Send ^a          ; ���� Ctrl+A ѡ��ȫ������
        Sleep 100        ; �ȴ� 10 ����
        Send ^c          ; ���� Ctrl+C ����
        Sleep 100        ; �ȴ� 10 ����
        Send {Esc}       ; ���� Esc �˳��༭ģʽ
    }
    return
}

CapsLock & Lshift::  ; ���� CapsLock + ��Shift
{	
	Send, ^!{Numpad1}
     ; ������ Shift
    DllCall("user32.dll\keybd_event", "UInt", 0xA1, "UInt", 0, "UInt", 0, "UInt", 0)  ; Right Shift Down

    ; �ȴ�Ƭ�̣�ģ�ⰴ����ס��Ч��
    Sleep 10

    ; �ͷ��� Shift
    DllCall("user32.dll\keybd_event", "UInt", 0xA1, "UInt", 0, "UInt", 2, "UInt", 0)  ; Right Shift Up


    return

}




;����ʱ�䵽���а�
CapsLock & T::
    Clipboard := A_YYYY "_" A_MM "_" A_DD " " A_Hour ":" A_Min ":" A_Sec
    Send ^v  ; ����ճ�����Ctrl + V��
return

;�������ֿ�ʼ


#Include %A_ScriptDir%\VA.ahk ; ���� VA.ahk ��,����������ǰ�����

CapsLock & F1:: ;caps+* hotkey - toggle mute state of active window
  WindowEXE := WinExist("A")
    ControlGetFocus, FocusedControl, ahk_id %WindowEXE%
    ControlGet, Hwnd, Hwnd,, %FocusedControl%, ahk_id %WindowEXE%
    WinGet, simplexe, processname, ahk_id %Hwnd%
  Loop, 3  ; �������3��
  {
    if (Volume := GetVolumeObject(simplexe))
    {
      VA_ISimpleAudioVolume_GetMute(Volume, Mute)
      VA_ISimpleAudioVolume_SetMute(Volume, !Mute)
      ObjRelease(Volume)
      return
    }
    Sleep, 1000  ; �ȴ�100ms������
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
 ;�������ֽ���





; Toggle CapsLock functionality with win + CapsLock
#CapsLock::
CapsLockState := (CapsLockState = "AlwaysOff") ? "AlwaysOn" : "AlwaysOff"
SetCapsLockState, %CapsLockState%
return






 
