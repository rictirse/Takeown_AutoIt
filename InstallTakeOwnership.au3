
RegWrite('HKEY_CLASSES_ROOT\*\shell\runas')
RegWrite('HKEY_CLASSES_ROOT\*\shell\runas', '', 'REG_SZ', 'Take Ownership')
RegWrite('HKEY_CLASSES_ROOT\*\shell\runas', 'NoWorkingDirectory', 'REG_SZ', '')

RegWrite('HKEY_CLASSES_ROOT\*\shell\runas\command')
RegWrite('HKEY_CLASSES_ROOT\*\shell\runas\command', '', 'REG_SZ', 'cmd.exe /c takeown /f "%1" && icacls "%1" /grant administrators:F')
RegWrite('HKEY_CLASSES_ROOT\*\shell\runas\command', 'IsolatedCommand', 'REG_SZ', 'cmd.exe /c takeown /f "%1" && icacls "%1" /grant administrators:F')

RegWrite('HKEY_CLASSES_ROOT\Directory\shell\runas')
RegWrite('HKEY_CLASSES_ROOT\Directory\shell\runas', '', 'REG_SZ', 'Take Ownership')
RegWrite('HKEY_CLASSES_ROOT\Directory\shell\runas', 'NoWorkingDirectory', 'REG_SZ', '')

RegWrite('HKEY_CLASSES_ROOT\Directory\shell\runas\command')
RegWrite('HKEY_CLASSES_ROOT\Directory\shell\runas\command', '', 'REG_SZ', 'cmd.exe /c takeown /f "%1" /r /d y && icacls "%1" /grant administrators:F /t')
RegWrite('HKEY_CLASSES_ROOT\Directory\shell\runas\command', 'IsolatedCommand', 'REG_SZ', 'cmd.exe /c takeown /f "%1" /r /d y && icacls "%1" /grant administrators:F /t')