#IfWinActive ahk_class SteinbergWindowClass ; 用于检测 Cubase 窗口是否处于活动状态

+WheelDown::Send +{WheelUp} ; 当按住 Shift 并向下滚动时，发送向上滚动指令
+WheelUp::Send +{WheelDown} ; 当按住 Shift 并向上滚动时，发送向下滚动指令

#IfWinActive ; 结束窗口活动状态检测