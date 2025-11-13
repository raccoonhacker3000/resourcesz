Write-Host "== Applying Security Options (CyberPatriot) =="

# Create temp folder
if (!(Test-Path C:\temp)) { New-Item -ItemType Directory -Path C:\temp > $null }

# Export current policy
secedit /export /cfg C:\temp\secopts.cfg > $null

# Load config
$cfg = Get-Content C:\temp\secopts.cfg

# Helper function to replace settings
function Set-PolicyLine($key, $value) {
    $script:cfg = $script:cfg -replace "^$key =.*", "$key = $value"
}

# ======================
#  SECURITY OPTIONS
# ======================

# --- Accounts ---
Set-PolicyLine "MACHINE\System\CurrentControlSet\Control\Lsa\LimitBlankPasswordUse" "4,1"
Set-PolicyLine "MACHINE\System\CurrentControlSet\Control\Lsa\NoLMHash" "4,1"
Set-PolicyLine "MACHINE\System\CurrentControlSet\Control\Lsa\UseMachineId" "4,1"

# --- Administrator account ---
Set-PolicyLine "MACHINE\System\CurrentControlSet\Control\Lsa\DisableDomainCreds" "4,1"

# --- Guest ---
Set-PolicyLine "MACHINE\System\CurrentControlSet\Control\Lsa\UseMachineId" "4,1"

# --- Audit ---
Set-PolicyLine "MACHINE\System\CurrentControlSet\Control\Lsa\SCENoApplyLegacyAuditPolicy" "4,1"

# --- Devices ---
Set-PolicyLine "MACHINE\System\CurrentControlSet\Control\Print\Providers\LanMan Print Services\Servers\AddPrinterDrivers" "4,1"

# --- Interactive Logon ---
Set-PolicyLine "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\DisableCAD" "4,0"
Set-PolicyLine "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\DontDisplayLastUserName" "4,1"
Set-PolicyLine "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\InactivityTimeoutSecs" "4,900"
Set-PolicyLine "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\LegalNoticeCaption" "1,WARNING!"
Set-PolicyLine "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\LegalNoticeText" "7,Unauthorized use of this computer is prohibited"

# --- Kernel / Driver ---
Set-PolicyLine "MACHINE\System\CurrentControlSet\Control\Session Manager\Kernel\ObCaseInsensitive" "4,1"

# --- Network Security ---
Set-PolicyLine "MACHINE\System\CurrentControlSet\Control\Lsa\LmCompatibilityLevel" "4,5"
Set-PolicyLine "MACHINE\System\CurrentControlSet\Control\Lsa\MSV1_0\NTLMMinClientSec" "4,536870912"
Set-PolicyLine "MACHINE\System\CurrentControlSet\Control\Lsa\MSV1_0\NTLMMinServerSec" "4,536870912"
Set-PolicyLine "MACHINE\System\CurrentControlSet\Control\Lsa\RestrictAnonymous" "4,1"
Set-PolicyLine "MACHINE\System\CurrentControlSet\Control\Lsa\RestrictAnonymousSAM" "4,1"
Set-PolicyLine "MACHINE\System\CurrentControlSet\Control\Lsa\everyoneincludesanonymous" "4,0"
Set-PolicyLine "MACHINE\System\CurrentControlSet\Control\Lsa\ForceGuest" "4,0"

# --- Shutdown ---
Set-PolicyLine "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\ShutdownWithoutLogon" "4,0"
Set-PolicyLine "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\DisableShutdownButton" "4,1"

# --- System Objects ---
Set-PolicyLine "MACHINE\System\CurrentControlSet\Control\Session Manager\ProtectionMode" "4,1"

# --- User Account Control (UAC) ---
Set-PolicyLine "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\ConsentPromptBehaviorAdmin" "4,2"
Set-PolicyLine "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\ConsentPromptBehaviorUser" "4,1"
Set-PolicyLine "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\EnableInstallerDetection" "4,1"
Set-PolicyLine "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\EnableLUA" "4,1"
Set-PolicyLine "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\EnableSecureUIAPaths" "4,1"
Set-PolicyLine "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\PromptOnSecureDesktop" "4,1"
Set-PolicyLine "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\ValidateAdminCodeSignatures" "4,0"
Set-PolicyLine "MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\FilterAdministratorToken" "4,1"

# Microsoft Network Client – SMB Signing
Set-PolicyLine "MACHINE\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\RequireSecuritySignature" "4,1"
Set-PolicyLine "MACHINE\System\CurrentControlSet\Services\LanmanWorkstation\Parameters\EnableSecuritySignature" "4,1"

# Save new config
$cfg | Set-Content C:\temp\secopts.cfg

# Apply it
secedit /configure /db C:\Windows\security\local.sdb /cfg C:\temp\secopts.cfg /areas SECURITYPOLICY > $null

Write-Host "Security Options successfully applied."
