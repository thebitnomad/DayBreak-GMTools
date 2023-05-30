'CheckGame
'通过进程Id检查进程是否存在

Dim m_Computer, m_ProcId
m_Computer		= "."
m_ProcId		= "58614"

Set m_objWMIService	= GetObject("winmgmts:{impersonationLevel=impersonate}!\\" & m_Computer & "\root\cimv2")
Set m_colProcessList	= m_objWMIService.ExecQuery( "Select * from Win32_Process Where processid=" & m_ProcId )
If m_colProcessList.Count > 0 Then
	WScript.Echo "1"
Else
	WScript.Echo "0"
End If
