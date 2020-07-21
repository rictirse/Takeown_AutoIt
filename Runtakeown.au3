#RequireAdmin


;;;~ NT SERVICE\TrustedInstaller


#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;~ F –完全訪問權限
;~ M –修改權限
;~ RX –讀取和執行權限
;~ R –只讀權限
;~ W –只寫權限
;~ 在括號中以逗號分隔列表的特定權限:
;~ D –刪除
;~ RC –讀取控制
;~ WDAC –寫入DAC
;~ WO –寫入所有者
;~ S –同步
;~ AS –訪問系統安全性
;~ MA –允許的最大值
;~ GR –一般性讀取
;~ GW ??–一般性寫入
;~ GE –一般性執行
;~ GA –全為一般性
;~ RD –讀取數據/列出目錄
;~ WD –寫入數據/添加文件
;~ AD –附加數據/添加子目錄
;~ REA –讀取擴展屬性
;~ WEA –寫入擴展屬性
;~ X –執行/遍歷
;~ DC –刪除子項
;~ RA –讀取屬性
;~ WA –寫入屬性
;~ 繼承權限可以優先於每種格式，但只應用於
;~ 目錄:
;~ (OI) –對象繼承
;~ (CI) –容器繼承
;~ (IO) –僅繼承
;~ (NP) –不傳播繼承

Dim $DirPath = "C:\Windows\System32"
Dim $FileName = "C_949.NLS"

_iCaclsRestoreDirTrustedInstaller ("C:\hh", @UserName)

Func _iCaclsGetDirAdmin ($DirPath)
	Local $command = 'takeown /f '&$DirPath&' /r /d y && icacls '&$DirPath&' /grant administrators:F /t'

	Run(@ComSpec & " /k " & $command, $DirPath, @SW_SHOW)
EndFunc

Func _iCaclsRestoreDirTrustedInstaller ($DirPath, $UserName="administrators")

;~ 	Local $command = 'takeown /f '&$DirPath&' && icacls '&$DirPath&' /grant:r administrators:(RX)'
	Local $command = 'takeown /f '&$DirPath&' && icacls '&$DirPath&' /grant:r '&$UserName&':(RX)'


	Local $command2 = 'takeown /f '&$DirPath&' && icacls '&$DirPath&' /setowner "NT Service\TrustedInstaller" /T /C'
		ClipPut ($command2)

	Exit
	Run(@ComSpec & " /k " & $command, $DirPath, @SW_SHOW)
	Run(@ComSpec & " /k " & $command2, $DirPath, @SW_SHOW)
EndFunc


Func _iCaclsGetFileAdmin ( $DirPath, $FileName)
	Local $FilePath = $DirPath&"\"&$FileName

	Local $command = 'takeown /f '&$FilePath&' && icacls '&$FilePath&' /grant administrators:F '
	Run(@ComSpec & " /k " & $command, $DirPath, @SW_SHOW)
EndFunc

Func _iCaclsRestoreFileTrustedInstaller ( $DirPath, $FileName)
	Local $FilePath = $DirPath&"\"&$FileName

	Local $command = 'takeown /f '&$FilePath&' && icacls '&$FilePath&' /grant:r administrators:(RX)'
	Local $command2 = 'takeown /f '&$FilePath&' && icacls '&$FilePath&' /setowner "NT Service\TrustedInstaller" /C'

	Run(@ComSpec & " /k " & $command, $DirPath, @SW_SHOW)
	Run(@ComSpec & " /k " & $command2, $DirPath, @SW_SHOW)
EndFunc