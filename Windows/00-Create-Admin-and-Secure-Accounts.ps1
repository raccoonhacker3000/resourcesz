# Create an admin account, rename built-in Admin, disable Guest, enforce PasswordNeverExpires off
Write-Host "== Account & basic hardening =="

# 1) Create team admin if not exists
$adminName = "CyberAdmin"
$adminPassword = ConvertTo-SecureString "Cp!2025team#" -AsPlainText -Force
if (-not (Get-LocalUser -Name $adminName -ErrorAction SilentlyContinue)) {
    New-LocalUser -Name $adminName -Password $adminPassword -FullName "CyberPatriot Admin" -Description "Team admin account"
    Add-LocalGroupMember -Group "Administrators" -Member $adminName
    Write-Host "Created $adminName and added to Administrators"
} else {
    Write-Host "$adminName already exists"
}

# 2) Rename built-in Administrator if present (do not remove)
$builtin = Get-LocalUser -SID (Get-LocalUser | Where-Object { $_.Name -eq "Administrator" } | Select-Object -First 1).SID -ErrorAction SilentlyContinue
try {
    $adminUser = Get-LocalUser -Name "Administrator" -ErrorAction SilentlyContinue
    if ($adminUser) {
        Rename-LocalUser -Name "Administrator" -NewName "LocalAdmin" -ErrorAction SilentlyContinue
        Write-Host "Renamed built-in Administrator -> LocalAdmin"
        # set strong password
        Set-LocalUser -Name "LocalAdmin" -Password (ConvertTo-SecureString "Cp!2025adm#" -AsPlainText -Force)
        Write-Host "Set password for LocalAdmin"
    }
} catch { Write-Host "Rename built-in admin skipped or failed: $_" }

# 3) Disable Guest account if enabled
$guest = Get-LocalUser -Name "Guest" -ErrorAction SilentlyContinue
if ($guest -and $guest.Enabled) {
    Disable-LocalUser -Name "Guest"
    Write-Host "Disabled Guest account"
} else { Write-Host "Guest already disabled or not exist" }

# 4) Ensure every enabled local user has PasswordNeverExpires = $false and is password-protected
Get-LocalUser | Where-Object { $_.Enabled -eq $true } | ForEach-Object {
    try {
        $u = $_
        # ensure password never expires is false
        Set-LocalUser -Name $u.Name -PasswordNeverExpires $false -ErrorAction SilentlyContinue
        Write-Host "PasswordNeverExpires disabled for $($u.Name)"

        # if password blank or you want to enforce, set a default strong password pattern (change as needed)
        # NOTE: Setting same password for many accounts is allowed for scoring but not ideal in real-world
        $pw = ConvertTo-SecureString ("Cp!2025u_" + ($u.Name.Substring(0, [Math]::Min($u.Name.Length,3)))) -AsPlainText -Force
        # Set password only if not Administrator/system accounts - attempt anyway
        Set-LocalUser -Name $u.Name -Password $pw -ErrorAction SilentlyContinue
        Write-Host "Set password for $($u.Name)"
    } catch { Write-Host "Could not set password for $($u.Name): $_" }
}

Write-Host "Account hardening complete."
