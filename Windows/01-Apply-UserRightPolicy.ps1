Write-Host "== Applying User Rights Assignment (CyberPatriot) =="

# Helper function for secedit commands
function Set-Right($Right, $Users) {
    secedit /export /cfg C:\temp\secp.cfg > $null
    (Get-Content C:\temp\secp.cfg) |
        ForEach-Object {
            if ($_ -match "^$Right") {
                "$Right = $Users"
            } else {
                $_
            }
        } | Set-Content C:\temp\secp.cfg

    secedit /configure /db C:\Windows\security\local.sdb /cfg C:\temp\secp.cfg /areas USER_RIGHTS > $null
}

# Local groups
$Admins = "*S-1-5-32-544"
$Users = "*S-1-5-32-545"
$Guests = "*S-1-5-32-546"
$RemoteDesktopUsers = "*S-1-5-32-555"

# ===== ALLOW ONLY ADMINS =====
Set-Right "SeNetworkLogonRight"            $Admins      # Access from network
Set-Right "SeRemoteInteractiveLogonRight"  $Admins      # Allow RDP
Set-Right "SeInteractiveLogonRight"        "$Admins,$Users"   # Local logon (users allowed)

# ===== DENY RIGHTS =====
Set-Right "SeDenyNetworkLogonRight"        $Guests
Set-Right "SeDenyInteractiveLogonRight"    $Guests
Set-Right "SeDenyRemoteInteractiveLogonRight" $Guests
Set-Right "SeDenyBatchLogonRight"          $Guests
Set-Right "SeDenyServiceLogonRight"        $Guests

# ===== PRIVILEGED RIGHTS (Admins ONLY) =====
Set-Right "SeBackupPrivilege"              $Admins
Set-Right "SeRestorePrivilege"             $Admins
Set-Right "SeDebugPrivilege"               $Admins
Set-Right "SeTakeOwnershipPrivilege"       $Admins
Set-Right "SeSecurityPrivilege"            $Admins
Set-Right "SeSystemEnvironmentPrivilege"   $Admins
Set-Right "SeSystemTimePrivilege"          $Admins
Set-Right "SeIncreaseQuotaPrivilege"       $Admins
Set-Right "SeLoadDriverPrivilege"          $Admins
Set-Right "SeLockMemoryPrivilege"          $Admins
Set-Right "SeManageVolumePrivilege"        $Admins
Set-Right "SeProfileSingleProcessPrivilege" $Admins
Set-Right "SeAuditPrivilege"               $Admins
Set-Right "SeCreatePermanentPrivilege"     $Admins

# ===== SERVICE/ADVANCED RIGHTS =====
Set-Right "SeAssignPrimaryTokenPrivilege"  $Admins
Set-Right "SeIncreaseBasePriorityPrivilege" $Admins
Set-Right "SeMachineAccountPrivilege"      $Admins
Set-Right "SeShutdownPrivilege"            $Admins
Set-Right "SeRemoteShutdownPrivilege"      $Admins
Set-Right "SeUndockPrivilege"              $Admins
Set-Right "SeChangeNotifyPrivilege"        "$Admins,$Users"  # Default; users need this
Set-Right "SeTimeZonePrivilege"            $Admins

# ===== BATCH/LOGON RIGHTS =====
Set-Right "SeBatchLogonRight"              ""        # Empty = NONE
Set-Right "SeServiceLogonRight"            ""        # No service accounts in CP images

# ===== SYSTEM RESOURCE MGMT =====
Set-Right "SeCreatePagefilePrivilege"      $Admins
Set-Right "SeCreateTokenPrivilege"         ""        # NEVER allow anyone
Set-Right "SeCreateGlobalPrivilege"        $Admins
Set-Right "SeCreateSymbolicLinkPrivilege"  $Admins   # Win10 default: admins only

# ===== FILE / PROCESS RIGHTS =====
Set-Right "SeRelabelPrivilege"             ""        # Empty = NONE
Set-Right "SeImpersonatePrivilege"         $Admins
Set-Right "SeDelegateSessionUserImpersonatePrivilege" "" # none
Set-Right "SeManageVolumePrivilege"        $Admins

Write-Host "User Rights Assignment applied successfully."
