Write-Host "=== CyberPatriot Suspicious File Scanner ===" -ForegroundColor Cyan

$SearchPaths = @(
    "C:\Users",
    "C:\ProgramData",
    "C:\Program Files",
    "C:\Program Files (x86)",
    "C:\Windows\Temp",
    "$env:TEMP"
)

# Suspicious file extensions
$BadExtensions = @("*.bat","*.cmd","*.ps1","*.vbs","*.js","*.wsf","*.exe","*.dll")

# Suspicious keywords
$BadKeywords = @(
    "torrent","utorrent","bittorrent",
    "hack","keylogger","remote","rat","backdoor",
    "update","patch","chrome","payload",
    "teamviewer","anydesk","vnc","putty","winscp","nmap","wireshark"
)

Write-Host "`nScanning for BAD EXTENSIONS..." -ForegroundColor Yellow
foreach ($ext in $BadExtensions) {
    foreach ($path in $SearchPaths) {
        Get-ChildItem -Path $path -Recurse -Filter $ext -ErrorAction SilentlyContinue |
        Select-Object FullName, LastWriteTime |
        Sort-Object LastWriteTime -Descending |
        Tee-Object -Append suspicious_files.txt
    }
}

Write-Host "`nScanning for BAD KEYWORDS..." -ForegroundColor Yellow
foreach ($word in $BadKeywords) {
    foreach ($path in $SearchPaths) {
        Get-ChildItem -Path $path -Recurse -ErrorAction SilentlyContinue |
        Where-Object { $_.Name -match $word } |
        Select-Object FullName, LastWriteTime |
        Sort-Object LastWriteTime -Descending |
        Tee-Object -Append suspicious_files.txt
    }
}

Write-Host "`nChecking STARTUP folders..." -ForegroundColor Yellow

$StartupPaths = @(
    "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup",
    "C:\Users\*\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
)

foreach ($sp in $StartupPaths) {
    Get-ChildItem -Path $sp -Recurse -ErrorAction SilentlyContinue |
    Select-Object FullName, LastWriteTime |
    Tee-Object -Append suspicious_files.txt
}

Write-Host "`nChecking scheduled tasks..." -ForegroundColor Yellow

Get-ScheduledTask |
Where-Object { $_.TaskName -match "update|chrome|script|vbs|ps1|bat" } |
Select-Object TaskName, TaskPath |
Tee-Object -Append suspicious_files.txt

Write-Host "`n=== DONE! Suspicious files saved to suspicious_files.txt ===" -ForegroundColor Green
