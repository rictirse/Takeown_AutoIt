#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <ProgressConstants.au3>
#include <Process.au3>
#include <EditConstants.au3>
#RequireAdmin
#NoTrayIcon

Global $TypeScript = "ExplorerFrameChanger", $Version = "V 1.0", $MadeBy = "By SneakyEric", $ExplorerFrame_Dir = "C:\Windows\SneakyEricTweak\ExplorerFrame"
Global $ODEXP, $AnyChanged = False

#Region - - Write - -
;WriteReplace
$h4File = FileOpen ( "C:\Windows\SneakyEricTweak\ExplorerFrame\Replace_ExplorerFrame.bat", 10 )
FileWrite ( $h4File, "taskkill /f /im explorer.exe" & @CRLF )
FileWrite ( $h4File, "takeown /f %systemroot%\system32\ExplorerFrame.dll && icacls %systemroot%\system32\ExplorerFrame.dll /grant administrators:F" & @CRLF )
FileWrite ( $h4File, "Move %systemroot%\System32\ExplorerFrame.dll %systemroot%\SneakyEricTweak\ExplorerFrame\ExplorerFrame_TEMP.dll" & @CRLF )
FileWrite ( $h4File, "copy %systemroot%\SneakyEricTweak\ExplorerFrame\ExplorerFrame_new.dll %systemroot%\System32\ExplorerFrame.dll" & @CRLF )
FileWrite ( $h4File, "del %systemroot%\SneakyEricTweak\ExplorerFrame\ExplorerFrame_new.dll" & @CRLF )
FileWrite ( $h4File, "del %systemroot%\SneakyEricTweak\ExplorerFrame\ExplorerFrame_TEMP.dll" & @CRLF )
FileWrite ( $h4File, "CD C:\Windows" & @CRLF )
FileWrite ( $h4File, "start explorer.exe" & @CRLF & "exit" )
FileClose ( $h4File )
;WriteRestore
$h5File = FileOpen ( "C:\Windows\SneakyEricTweak\ExplorerFrame\Restore_ExplorerFrame.bat", 10 )
FileWrite ( $h5File, "taskkill /f /im explorer.exe" & @CRLF )
FileWrite ( $h5File, "takeown /f %systemroot%\system32\ExplorerFrame.dll && icacls %systemroot%\system32\ExplorerFrame.dll /grant administrators:F" & @CRLF )
FileWrite ( $h5File, "Move %systemroot%\System32\ExplorerFrame.dll %systemroot%\SneakyEricTweak\ExplorerFrame\ExplorerFrame_TEMP.dll" & @CRLF )
FileWrite ( $h5File, "copy %systemroot%\SneakyEricTweak\ExplorerFrame\ExplorerFrame_backup.dll %systemroot%\System32\ExplorerFrame.dll" & @CRLF )
FileWrite ( $h5File, "del %systemroot%\SneakyEricTweak\ExplorerFrame\ExplorerFrame_TEMP.dll" & @CRLF )
FileWrite ( $h5File, "CD C:\Windows" & @CRLF )
FileWrite ( $h5File, "start explorer.exe" & @CRLF & "exit" )
FileClose ( $h5File )
;WriteBackup
$h6File = FileOpen ( "C:\Windows\SneakyEricTweak\ExplorerFrame\Backup_ExplorerFrame.bat", 10 )
FileWrite ( $h6File, "taskkill /f /im explorer.exe" & @CRLF )
FileWrite ( $h6File, "takeown /f %systemroot%\system32\ExplorerFrame.dll && icacls %systemroot%\system32\ExplorerFrame.dll /grant administrators:F" & @CRLF )
FileWrite ( $h6File, "copy %systemroot%\system32\ExplorerFrame.dll %systemroot%\SneakyEricTweak\ExplorerFrame\ExplorerFrame_backup.dll" & @CRLF )
FileWrite ( $h6File, "CD C:\Windows" & @CRLF )
FileWrite ( $h6File, "start explorer.exe" & @CRLF & "exit" )
FileClose ( $h6File )
#EndRegion
#Region - - Main GUI - -
$MainGUI        =       GUICreate ( $TypeScript & " - " & $Version & " - " & $MadeBy, 400, 150 )

$LabEXP         =       GUICtrlCreateLabel ( "ExplorerFrame.dll:", 10, 13 )
$InpEXP         =       GUICtrlCreateInput ( "Path", 95, 10, 225, 20, $ES_READONLY )
$ButEXP         =       GUICtrlCreateButton ( "Browse...", 325, 8, 70, 24 )

$REF            =       GUICtrlCreateButton ( "Replace ExplorerFrame", 5, 37, 390, 30 )
$RBEF           =       GUICtrlCreateButton ( "Restore ExplorerFrame", 5, 72, 190, 30 )
$MBEF           =       GUICtrlCreateButton ( "Backup ExplorerFrame", 200, 72, 195, 30 )

                                GUICtrlCreateGroup ( "Advanced options", 8, 105, 385, 38 )
$ABEF           =       GUICtrlCreateCheckBox ( "Automatic Backup", 14, 118 )
$DSDMEF         =       GUICtrlCreateCheckBox ( "Dont show done messages", 205, 118 )
                                GUISetState ( @SW_SHOW, $MainGUI )
#EndRegion


While 1
        $msg = GUIGetMsg()
                Select
                        Case $msg = $GUI_EVENT_CLOSE
                                ExitLoop
                        Case $msg = $ButEXP
                                $ODEXP = FileOpenDialog ( "Browse ExplorerFrame.dll...", @MyDocumentsDir, "dll (*.dll)" )
                                GUICtrlSetData ( $InpEXP, $ODEXP )
                        Case $msg = $REF
                                If GUICtrlRead ( $InpEXP ) <> "Path" Then
                                        FileCopy ( $ODEXP, $ExplorerFrame_Dir & "\ExplorerFrame_new.dll", 9 )
                                        $AnyChanged = True
                                EndIf
                                If $AnyChanged == True Then     ReplaceSystemExplorerFrame ( )
                        Case $msg = $RBEF
                                RestoreSystemExplorerFrame ( )
                        Case $msg = $MBEF
                                BackupSystemExplorerFrame ( )
                EndSelect
WEnd


Func ReplaceSystemExplorerFrame ( )
        If GUICtrlRead ( $ABEF ) = $GUI_CHECKED Then
                RunWait ( "C:\Windows\SneakyEricTweak\ExplorerFrame\Backup_ExplorerFrame.bat", "C:\Windows\SneakyEricTweak\ExplorerFrame", @SW_HIDE )
        EndIf
        RunWait ( "C:\Windows\SneakyEricTweak\ExplorerFrame\Replace_ExplorerFrame.bat", "C:\Windows\SneakyEricTweak\ExplorerFrame", @SW_HIDE )
        If GUICtrlRead ( $DSDMEF ) = $GUI_UNCHECKED Then
                MsgBox ( 0, "Items replaced", "The explorerframe is replaced, if you don't see any changes please restart your computer or try it again." )
        EndIf
        $AnyChanged = False
EndFunc
Func RestoreSystemExplorerFrame ( )
        If GUICtrlRead ( $ABEF ) = $GUI_CHECKED Then
                RunWait ( "C:\Windows\SneakyEricTweak\ExplorerFrame\Backup_ExplorerFrame.bat", "C:\Windows\SneakyEricTweak\ExplorerFrame", @SW_HIDE )
        EndIf
        RunWait ( "C:\Windows\SneakyEricTweak\ExplorerFrame\Restore_ExplorerFrame.bat", "C:\Windows\SneakyEricTweak\ExplorerFrame", @SW_HIDE )
        If GUICtrlRead ( $DSDMEF ) = $GUI_UNCHECKED Then
                MsgBox ( 1, "Backup restored", "Backup is restored" )
        EndIf
EndFunc
Func BackupSystemExplorerFrame ( )
        RunWait ( "C:\Windows\SneakyEricTweak\ExplorerFrame\Backup_ExplorerFrame.bat", "C:\Windows\SneakyEricTweak\ExplorerFrame", @SW_HIDE )
        If GUICtrlRead ( $DSDMEF ) = $GUI_UNCHECKED Then
                MsgBox ( 1, "Backup done", "Backup is done" )
        EndIf
EndFunc