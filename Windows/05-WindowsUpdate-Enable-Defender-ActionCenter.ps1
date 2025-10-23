Write-Host "== Windows Update, Defender, Action Center =="
# Start Windows Update service and set to automatic
Set-Service -Name wuauserv -StartupType Automatic -ErrorAction SilentlyContinue
Start-Service -Name wuauserv -ErrorAction SilentlyContinue

# Trigger detection (may be deprecated but helps)
try { (New-Object -ComObject Microsoft.Update.AutoUpdate).DetectNow() } catch { }

# Windows Defender: enable realtime if available
if (Get-Command "Set-MpPreference" -ErrorAction SilentlyContinue) {
    Set-MpPreference -DisableRealtimeMonitoring $false
    Write-Host "Enabled Defender realtime monitoring"
} else {
    Write-Host "Windows Defender cmdlets not available on this OS"
}

# Enable Action Center via registry (HKCU policy)
$regPath = "HKCU:\Software\Policies\Microsoft\Windows\Explorer"
if (-not (Test-Path $regPath)) { New-Item -Path $regPath -Force | Out-Null }
Set-ItemProperty -Path $regPath -Name "DisableNotificationCenter" -Value 0 -Force
Write-Host "Action Center (notification center) enabled (registry). User may need to sign out/in."

Write-Host "Windows Update & Defender steps complete. Reboot recommended to finalize updates."
