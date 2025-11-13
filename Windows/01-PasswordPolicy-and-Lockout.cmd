@echo off
echo =======================================================
echo     CyberPatriot Password + Lockout Policy Script
echo =======================================================

:: ---------------------------------------------------------
:: 1) PASSWORD POLICY  (Net Accounts)
:: ---------------------------------------------------------
echo [1/3] Applying net accounts password policy...

rem Minimum password length: 14
rem Maximum password age: 60 days
rem Minimum password age: 1 day
rem Password history: 5
net accounts /minpwlen:14 /maxpwage:60 /minpwage:1 /uniquepw:5

echo Password policy via net accounts applied.


:: ---------------------------------------------------------
:: 2) PASSWORD POLICY (LGPO.exe - required for complexity)
:: ---------------------------------------------------------
echo [2/3] Applying password complexity + reversible encryption...

:: Require password complexity (Uppercase + Lowercase + Number + Symbol)
lgpo.exe /t passwordpolicy /v "PasswordComplexity" /d 1

:: Disable storing passwords using reversible encryption
lgpo.exe /t passwordpolicy /v "ClearTextPassword" /d 0

echo Complexity + reversible encryption applied.


:: ---------------------------------------------------------
:: 3) ACCOUNT LOCKOUT POLICY (LGPO.exe)
:: ---------------------------------------------------------
echo [3/3] Applying account lockout settings...

:: Lockout threshold (also set by net accounts, but LGPO ensures UI sync)
lgpo.exe /t lockoutpolicy /v "LockoutBadCount" /d 5

:: Lockout duration: 30 minutes
lgpo.exe /t lockoutpolicy /v "LockoutDuration" /d 30

:: Reset lockout counter after: 30 minutes
lgpo.exe /t lockoutpolicy /v "ResetLockoutCount" /d 30

echo Account lockout policy applied.


echo =======================================================
echo   DONE! All settings have been applied.
echo   Verify in secpol.msc -> Account Policies
echo =======================================================
pause
