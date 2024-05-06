#Persistent
#NoEnv
Flag := false

; 定义变量来跟踪Win键的状态

; 按下Win键时将WinPressed设置为true
~Lwin up::
    WinPressed := false
    if(Flag){
    Flag := false
    Send, ^{.} ; 发送Ctrl + .
}
    return
~#Space::
    Flag := true
    return