#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


; Alt + ` -  Activate next window of the current app
!`::

; Get the current process name
WinGet, ProcNameVar, ProcessName, A ; ahk_exe

; Get the Windows class for the active window, which is necessary
WinGetClass, ActiveClassVar, A

; Get the count of the windows for the class in ActiveClass
WinGet, WinClassCountVar, Count, ahk_class %ActiveClassVar%

; Display what we got
; MsgBox, ActiveClass %ActiveClassVar% ProcName %ProcNameVar% WinClassCount %WinClassCountVar%

WinGet, ListVar, List, ahk_exe %ProcNameVar%

Loop, %ListVar%
{
    ; Get out next index and hwnd
    index := ListVar - A_Index + 1
    hwnd := ListVar%index%

    ; Get the min/max state for the current window
    WinGet, StateVar, MinMax, % "ahk_id " List%hwnd%

    ; Get the class for the current window, to make sure it's the same as the active window
    WinGetClass, CurrentClassVar, ahk_id %hwnd%

    if (StateVar <> -1 && ActiveClassVar == CurrentClassVar)
    {
        WinGetClass, WinClassVar, ahk_id  %hwnd%
        WinGetTitle, TitleVar, ahk_id %hwnd%
        ;MsgBox, hwnd %hwnd% WinClass %WinClassVar% The active window is "%TitleVar%".
        break
    }
}
WinActivate, ahk_id %hwnd%
Return
