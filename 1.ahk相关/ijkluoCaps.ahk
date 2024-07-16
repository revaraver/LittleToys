; AutoHotkey script to disable capslock and make capslock+ijkl behave like arrow keys (ish),
; and implement capslock toggling functionality with Shift + CapsLock.

#NoTrayIcon

CapsLockState := "AlwaysOff"
SetCapsLockState, %CapsLockState%
MouseMoveDistance := 70  ; ��������ƶ��������
#MouseMoveDistanceS := 300  ; ��������ƶ��������

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
   

;�༭���ر��¼�,���godot4.3����ȸ�ƴ����ͻ
CapsLock & f::
    ; �����ǰ������� Godot �༭��
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


;�༭���ر��¼�,���godot4����ȸ�ƴ����ͻ
#if WinActive("ahk_class Engine")

	
    Shift & 1::
        ClipSaved := ClipboardAll
        Clipboard := "!"  ; ����̾��д�������
        Send, ^v  ; ���� Ctrl + V ճ������������
        Clipboard := ClipSaved
    return

    Shift & 3::
        ClipSaved := ClipboardAll
        Clipboard := "#"  ; ������д�������
        Send, ^v  ; ���� Ctrl + V ճ������������
        Clipboard := ClipSaved
    return

    Shift & 4::
        ClipSaved := ClipboardAll
        Clipboard := "$"  ; ����Ԫ����д�������
        Send, ^v  ; ���� Ctrl + V ճ������������
        Clipboard := ClipSaved
    return

    Shift & 5::
        ClipSaved := ClipboardAll
        Clipboard := "%"  ; ���ٷֺ�д�������
        Send, ^v  ; ���� Ctrl + V ճ������������
        Clipboard := ClipSaved
    return

    Shift & 7::
        ClipSaved := ClipboardAll
        Clipboard := "&"  ; ��&��д�������
        Send, ^v  ; ���� Ctrl + V ճ������������
        Clipboard := ClipSaved
    return

    Shift & 9::
        ClipSaved := ClipboardAll
        Clipboard := "("  ; ��������д�������
        Send, ^v  ; ���� Ctrl + V ճ������������
        Clipboard := ")"
        Send, ^v  ; ���� Ctrl + V ճ������������
        Send, {Left}
        Clipboard := ClipSaved
    return

    Shift & .::
        ClipSaved := ClipboardAll
        Clipboard := ">"  ; �����ں�д�������
        Send, ^v  ; ���� Ctrl + V ճ������������
        Clipboard := ClipSaved
    return

    '::  ; ������
        ClipSaved := ClipboardAll
        Clipboard := "'"  ; ��������д�������
        Send, ^v  ; ���� Ctrl + V ճ������������
        Clipboard := ClipSaved
    return

    "::  ; ˫����
        ClipSaved := ClipboardAll
        Clipboard := """"""  ; ��˫����д�������
        Send, ^v  ; ���� Ctrl + V ճ������������
        Send, {Left}
        Clipboard := ClipSaved
    return

    .::  ; ���
        ClipSaved := ClipboardAll
        Clipboard := "."  ; �����д�������
        Send, ^v  ; ���� Ctrl + V ճ������������
        Clipboard := ClipSaved
    return

    NumpadDot::
        ClipSaved := ClipboardAll
        Clipboard := "."  ; �����д�������
        Send, ^v  ; ���� Ctrl + V ճ������������
        Clipboard := ClipSaved
    return

    -::
        ClipSaved := ClipboardAll
        Clipboard := "-"  ; ��С�ں�д�������
        Send, ^v  ; ���� Ctrl + V ճ������������
        Clipboard := ClipSaved
    return

    NumpadSub::
        ClipSaved := ClipboardAll
        Clipboard := "-"  ; ��С�ں�д�������
        Send, ^v  ; ���� Ctrl + V ճ������������
        Clipboard := ClipSaved
    return
	
	Shift & NumpadSub::
        ClipSaved := ClipboardAll
        Clipboard := "-"  ; ��С�ں�д�������
        Send, ^v  ; ���� Ctrl + V ճ������������
        Clipboard := ClipSaved
    return

    NumpadAdd::
        ClipSaved := ClipboardAll
        Clipboard := "+"  ; ���Ӻ�д�������
        Send, ^v  ; ���� Ctrl + V ճ������������
        Clipboard := ClipSaved
    return
	

#if

;����ʱ�䵽���а�
CapsLock & T::
    Clipboard := A_YYYY "_" A_MM "_" A_DD " " A_Hour ":" A_Min ":" A_Sec
    Send ^v  ; ����ճ�����Ctrl + V��
return


; ȫ�ֱ����洢����״̬
wPressed := 0
aPressed := 0
sPressed := 0
dPressed := 0

; ��ⰴ������
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

; ��ⰴ���ͷ�
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


; ��鷽���ƶ����
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






 
