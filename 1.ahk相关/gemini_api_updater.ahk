#SingleInstance, Force
SetWorkingDir, %A_ScriptDir%

CoordMode, Mouse, Screen

MouseGetPos, MouseX, MouseY

; --- UI 界面定义 ---
Gui, Add, Button, x20 y20 w150 h30 Default gSaveChat, 1. 保存对话并更换API
Gui, Add, Button, x190 y20 w150 h30 gNoSaveChat, 2. 仅更换API
Gui, Add, Button, x20 y60 w150 h30 gStatsMode, 3. 发送 /stats modell

; 显示UI窗口
Gui, Show, X%MouseX% Y%MouseY% w360 h110, Gemini API 管理
Return

; --- UI 快捷键定义 ---
#IfWinActive, Gemini API 管理
1::
    Gosub, SaveChat
Return

2::
    Gosub, NoSaveChat
Return

3::
    Gosub, StatsMode
Return
#IfWinActive

; --- 按钮功能定义 ---

; “1. 保存对话并更换API” 按钮的功能
SaveChat:
Gui, Destroy
FormatTime, ChatTimestamp, , yyyyMMddHHmm
Click
Sleep, 100
PasteAndEnter("/chat save " . ChatTimestamp)
Sleep, 1500
Send, ^c
Sleep, 300
Send, ^c
Sleep, 100
UpdateApiKey()
Sleep, 100
Click
Sleep, 200
PasteAndEnter("gemini")
Sleep, 7000
PasteAndEnter("/chat resume " . ChatTimestamp)
sleep 200
Send, {Enter}
ExitApp ; 任务完成后退出脚本

; “2. 仅更换API” 按钮的功能
NoSaveChat:
Gui, Destroy
UpdateApiKey()
ExitApp ; 任务完成后退出脚本

; “3. 发送 /stats model” 按钮的功能
StatsMode:
Gui, Destroy
PasteAndEnter("/stats model")
ExitApp ; 任务完成后退出脚本


GuiClose:
ExitApp

;#################################################################
; 函数区域
;#################################################################

; (函数部分保持不变)
PasteAndEnter(text_to_paste)
{
    local OldClipboard := ClipboardAll
    Clipboard := text_to_paste
    ClipWait, 0.5
    if (ErrorLevel)
    {
        MsgBox, 写入剪贴板时发生错误！
        Return
    }
    Send, ^v
    Sleep, 200
    Send, {Enter}
    Sleep, 200
    Clipboard := OldClipboard
    OldClipboard := ""
}

UpdateApiKey()
{
    envFile := "D:\Users\revar\Documents\同步调谐师\.env"
    apiFile := "d:\Users\revar\Desktop\geminiApi.txt"
    FileRead, envContent, %envFile%
    FileRead, apiKeys, %apiFile%
    RegExMatch(envContent, "GEMINI_API_KEY=\K.*", currentApiKey)
    apiKeyArray := StrSplit(apiKeys, "`n", "`r")
    newApiKey := ""
    currentApiKeyIndex := 0
    nextIndex := 0
    Loop, % apiKeyArray.MaxIndex()
    {
        if (apiKeyArray[A_Index] = currentApiKey)
        {
            currentApiKeyIndex := A_Index
            nextIndex := Mod(A_Index, apiKeyArray.MaxIndex()) + 1
            newApiKey := apiKeyArray[nextIndex]
            break
        }
    }
    if (newApiKey)
    {
        StringReplace, newEnvContent, envContent, %currentApiKey%, %newApiKey%
        FileDelete, %envFile%
        FileAppend, %newEnvContent%, %envFile%
        ToolTip, % "API 已从第 " . currentApiKeyIndex . " 行`n" . currentApiKey . "`n`n更换为第 " . nextIndex . " 行`n" . newApiKey
        Sleep, 2000
        ToolTip
    }
    else
    {
        ToolTip, 错误: 未在 geminiApi.txt 中找到当前的 API Key！
        Sleep, 2000
        ToolTip
    }
}
