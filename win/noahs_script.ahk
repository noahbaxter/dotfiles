#NoEnv
#NoTrayIcon
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

XButton2::PgUp
XButton1::PgDn

^+MButton::ShowDesktops()
^+XButton2::DesktopRight()
^+XButton1::DesktopLeft()

ShowDesktops()
{
    Send #{Tab}
}

DesktopRight()
{
    Send ^#{Right}
}

DesktopLeft()
{
    Send ^#{Left}
}
