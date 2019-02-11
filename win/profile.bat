:: Place this in %systemroot%\System32\Repl\Imports\Scripts

:: Set CMD color
B:\Dev\reqs\colortool\colortool.exe B:\Dev\misc\dotfiles\win\OneHalfLight.itermcolors

:: Custom Prompt
prompt $E[1;31m%username%$E[0m at $E[1;33m%computername%$E[0m in $E[1;32m$P$E[0m$_$$ 

:: Commands
DOSKEY l=dir
DOSKEY ls=dir /w /a-h
DOSKEY la=dir /a
DOSKEY ll=dir /a

DOSKEY cl=cls
DOSKEY clear=cls
DOSKEY open=start $*
DOSKEY subl="C:\Program Files\Sublime Text 3\sublime_text.exe" $*

:: Directory Shortcuts
DOSKEY ~=cd %USERPROFILE%$* 
DOSKEY ..=cd ..
DOSKEY ....=cd ..\..
DOSKEY ......=cd ..\..\..
DOSKEY ........=cd ..\..\..\..

:: Go to user and clear screen
cd %USERPROFILE%
cls