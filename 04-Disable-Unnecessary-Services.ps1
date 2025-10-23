Write-Host "== Disabling known-insecure/unneeded services =="
$services = @(
  "TlntSvr",     # Telnet Server
  "w3svc",       # World Wide Web Publishing Service (IIS)
  "FTPSVC",      # FTP Service (may not exist)
  "RemoteRegistry",
  "upnphost",    # UPnP Host
  "SSDPSRV",     # SSDP Discovery
  "Messenger",   # Windows Messenger (legacy)
  "SstpSvc"      # Review, might not exist
)

foreach ($s in $services) {
    try {
        if (Get-Service -Name $s -ErrorAction SilentlyContinue) {
            Set-Service -Name $s -StartupType Disabled -ErrorAction SilentlyContinue
            Stop-Service -Name $s -Force -ErrorAction SilentlyContinue
            Write-Host "Disabled and stopped service: $s"
        } else {
            Write-Host "Service not present: $s"
        }
    } catch { Write-Host "Error handling $s: $_" }
}
Write-Host "Service configuration complete. Review with Get-Service."
