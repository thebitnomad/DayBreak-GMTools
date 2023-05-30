'SetupGame 安装游戏服务器

'设置工作目录为detector目录(即当前脚本所在目录的父目录)
Dim m_scriptDir, m_cmdDir, m_detectDir
m_scriptDir		= GetFileDir( WScript.ScriptFullName )
m_detectDir		= GetFileDir( Left( m_scriptDir, Len( m_scriptDir ) - 1 ) )

Dim m_objWshShell
Set m_objWshShell = WScript.CreateObject( "WScript.Shell" )
m_objWshShell.CurrentDirectory = m_detectDir

Dim m_7zAppPath, m_SvrDir, m_PakName, m_PakSourcePath
m_7zAppPath	= "7z.exe"
m_SvrDir	= "D:\server"
m_PakName	= "svrpak.7z"
m_PakSourcePath	= m_PakName
m_7zCmd		= "x """ & m_PakSourcePath & """ -o""" & m_SvrDir & """ -aoa"

'服务器目录如果存在则删除并重新建
Set m_objFSO = CreateObject( "Scripting.FileSystemObject" )
If m_objFSO.FolderExists( m_SvrDir ) Then
	m_objFSO.DeleteFolder m_SvrDir, True
	m_objFSO.CreateFolder m_SvrDir
End If
Set m_objFSO = Nothing

'执行7z.exe命令行覆盖解压至服务器所在目录
Set objWScript	= WScript.CreateObject( "WScript.Shell" )
Set objExec	= objWScript.Exec( """" & m_7zAppPath & """ " & m_7zCmd )

'等待7z进程退出
While objExec.Status <> 1
	WScript.Sleep 1
Wend

'根据7z退出码决定输出信息及退出码
WScript.Echo objExec.ExitCode
WScript.Quit objExec.ExitCode

'Functions
Function GetFileDir( filePath )
	Dim regEx
	Set regEx = New RegExp
	RegEx.Pattern = "([^\\/]*)$"
	' 替换掉正斜杠/或者反斜杠\后面的内容
	GetFileDir = RegEx.Replace( filePath, "" )
	Set regEx = Nothing
End Function
