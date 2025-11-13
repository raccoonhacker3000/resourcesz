Write-Host "======================================================="
Write-Host " CyberPatriot Password + Lockout Policy Script (PS1)"
Write-Host "======================================================="

# ---------------------------------------------------------
# 1) Basic Password Policy via net accounts
# ---------------------------------------------------------
Write-Host "[1/3] Applying net accounts password policy..."

net accounts /minpwlen:14 /maxpwage:60 /minpwage:1 /uniquepw:5 /lockoutthreshold:5

Write-Host "Net accounts policies applied."


# ---------------------------------------------------------
# 2) Build security template (INF file)
# ---------------------------------------------------------
Write-Host "[2/3] Creating temporary security template..."

$inf = @"
[Version]
signature=`"$CHICAGO$`"
Revision=1

[System Access]
PasswordComplexity=1
ClearTextPassword=0
LockoutBadCount=5
LockoutDuration=30
ResetLockoutCount=30
"@

$inf | Out-File -FilePath "cp_security.inf" -Encoding ASCII

Write-Host "Security template created."


# ---------------------------------------------------------
# 3) Apply template using secedit
# ---------------------------------------------------------
Write-Host "[3/3] Applying template with secedit..."

secedit /configure /db cp_security.sdb /cfg cp_security.inf /overwrite

Write-Host "Security template applied."


# ---------------------------------------------------------
# Cleanup
# ---------------------------------------------------------
Remove-Item cp_security.inf -Force -ErrorAction SilentlyContinue
Remove-Item cp_security.sdb -Force -ErrorAction SilentlyContinue

Write-Host "======================================================="
Write-Host " DONE! Check secpol.msc → Account Policies"
Write-Host "======================================================="
