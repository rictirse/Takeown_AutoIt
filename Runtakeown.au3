#RequireAdmin


;;;~ NT SERVICE\TrustedInstaller


#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;~ F �V�����X���v��
;~ M �V�ק��v��
;~ RX �VŪ���M�����v��
;~ R �V�uŪ�v��
;~ W �V�u�g�v��
;~ �b�A�����H�r�����j�C���S�w�v��:
;~ D �V�R��
;~ RC �VŪ������
;~ WDAC �V�g�JDAC
;~ WO �V�g�J�Ҧ���
;~ S �V�P�B
;~ AS �V�X�ݨt�Φw����
;~ MA �V���\���̤j��
;~ GR �V�@���Ū��
;~ GW ??�V�@��ʼg�J
;~ GE �V�@��ʰ���
;~ GA �V�����@���
;~ RD �VŪ���ƾ�/�C�X�ؿ�
;~ WD �V�g�J�ƾ�/�K�[���
;~ AD �V���[�ƾ�/�K�[�l�ؿ�
;~ REA �VŪ���X�i�ݩ�
;~ WEA �V�g�J�X�i�ݩ�
;~ X �V����/�M��
;~ DC �V�R���l��
;~ RA �VŪ���ݩ�
;~ WA �V�g�J�ݩ�
;~ �~���v���i�H�u����C�خ榡�A���u���Ω�
;~ �ؿ�:
;~ (OI) �V��H�~��
;~ (CI) �V�e���~��
;~ (IO) �V���~��
;~ (NP) �V���Ǽ��~��

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