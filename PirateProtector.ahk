;
; AutoHotkey
; Language:       English
; Platform:       Tested on Win 8.1
; Author:         DarthRampant <DarthRampant@gmail.com>
;
; Script Function:
;	Blocks all incoming and outgoing connections from all .exe within a selected folder, including all the subfolders
;

RunAsAdmin()

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%

FileSelectFolder,Selectedfolder
If (SelectedFolder != ""){
Loop, %SelectedFolder%\*.exe,1,1
{
	MyFile="%A_LoopFileFullPath%"
	FileName="DarthRampant %A_LoopFileName%"
	FirewallIn:="netsh advfirewall firewall add rule name=" FileName " dir=in action=block program="MyFile
	FirewallOut:="netsh advfirewall firewall add rule name=" FileName " dir=out action=block program="MyFile
	Run, %FirewallIn%
	Run, %FirewallOut%
	}
}


RunAsAdmin() {
	Global 0
	IfEqual, A_IsAdmin, 1, Return 0
	Loop, %0%
		params .= A_Space . %A_Index%
	DllCall("shell32\ShellExecute" (A_IsUnicode ? "":"A"),uint,0,str,"RunAs",str,(A_IsCompiled ? A_ScriptFullPath
	: A_AhkPath),str,(A_IsCompiled ? "": """" . A_ScriptFullPath . """" . A_Space) params,str,A_WorkingDir,int,1)
	ExitApp
}