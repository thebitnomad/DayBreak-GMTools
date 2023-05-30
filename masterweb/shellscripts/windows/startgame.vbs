'StartGame

Dim m_SvrWorkingDir, m_SvrAppName
m_SvrWorkingDir = "F:\testsvr"
m_SvrAppName = "server.exe -r"

Dim m_WshShell
Set m_WshShell = WScript.CreateObject( "WScript.Shell" )
m_WshShell.CurrentDirectory = m_SvrWorkingDir

Set objExec = m_WshShell.Exec( m_SvrAppName )
WScript.Echo objExec.ProcessID
