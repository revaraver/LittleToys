#Persistent
;#NoTrayIcon
if WinActive("ahk_class Engine")
{
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
}

