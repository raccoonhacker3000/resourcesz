@echo off
echo === Applying CyberPatriot Security Options ===

REM -----------------------------------------------------
REM 1. CTRL+ALT+DEL (must be REQUIRED)
REM -----------------------------------------------------
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableCAD /t REG_DWORD /d 0 /f

REM -----------------------------------------------------
REM 2. Do NOT display last username
REM -----------------------------------------------------
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DontDisplayLastUserName /t REG_DWORD /d 1 /f

REM -----------------------------------------------------
REM 3. Set legal notice banner (CyberPatriot safe)
REM -----------------------------------------------------
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v LegalNoticeCaption /t REG_SZ /d "WARNING" /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v LegalNoticeText /t REG_SZ /d "Unauthorized use of this computer is prohibited." /f

REM -----------------------------------------------------
REM 4. Inactivity timeout = 900 seconds (15 min)
REM -----------------------------------------------------
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v InactivityTimeoutSecs /t REG_DWORD /d 900 /f

REM -----------------------------------------------------
REM 5. Shutdown without logon = Disabled
REM -----------------------------------------------------
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v ShutdownWithoutLogon /t REG_DWORD /d 0 /f

REM -----------------------------------------------------
REM 6. Disable Shutdown button on logon screen
REM -----------------------------------------------------
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableShutdownButton /t REG_DWORD /d 1 /f

REM -----------------------------------------------------
REM 7. Limit blank passwords to console logon only
REM -----------------------------------------------------
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v LimitBlankPasswordUse /t REG_DWORD /d 1 /f

REM -----------------------------------------------------
REM 8. Do NOT store LAN Manager (LM) hashes
REM -----------------------------------------------------
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v NoLMHash /t REG_DWORD /d 1 /f

REM -----------------------------------------------------
REM 9. Restrict anonymous access (standard CP requirement)
REM -----------------------------------------------------
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v restrictanonymous /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v restrictanonymoussam /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v everyoneincludesanonymous /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v forceguest /t REG_DWORD /d 0 /f

REM -----------------------------------------------------
REM 10. Require NTLMv2 only (LmCompatibilityLevel = 5)
REM -----------------------------------------------------
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v LmCompatibilityLevel /t REG_DWORD /d 5 /f

REM -----------------------------------------------------
REM 11. Disable domain credential caching
REM -----------------------------------------------------
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v DisableDomainCreds /t REG_DWORD /d 1 /f

REM -----------------------------------------------------
REM 12. Prevent local print driver installation
REM -----------------------------------------------------
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Print\Providers\LanMan Print Services\Servers" /v AddPrinterDrivers /t REG_DWORD /d 1 /f

REM -----------------------------------------------------
REM 13. UAC Settings (all CyberPatriot standard)
REM -----------------------------------------------------
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v PromptOnSecureDesktop /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 2 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorUser /t REG_DWORD /d 1 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableInstallerDetection /t REG_DWORD /d 1 /f

REM -----------------------------------------------------
REM 14. SMB SIGNING (correct for CyberPatriot)
REM Client side ONLY in Training Round
REM -----------------------------------------------------
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v RequireSecuritySignature /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" /v EnableSecuritySignature /t REG_DWORD /d 1 /f

echo.
echo Security Options applied successfully!
echo Run: secpol.msc to verify.
echo.

pause
exit
