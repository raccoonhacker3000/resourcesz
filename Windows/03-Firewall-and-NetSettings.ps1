Write-Host "== Configuring Windows Firewall =="
# Enable firewall and set default inbound to Block, outbound Allow
Set-NetFirewallProfile -Profile Domain,Private,Public -Enabled True -DefaultInboundAction Block -DefaultOutboundAction Allow

# Set notification to true (so the system prompts when a new app requests inbound)
Set-NetFirewallProfile -Profile Domain,Private,Public -NotifyOnListen True

# Disable risky inbound features (File and Printer Sharing, Remote Assistance, RDP)
Get-NetFirewallRule | Where-Object { $_.DisplayName -match "File and Printer Sharing" } | Disable-NetFirewallRule -ErrorAction SilentlyContinue
Get-NetFirewallRule | Where-Object { $_.DisplayName -match "Remote Desktop" } | Disable-NetFirewallRule -ErrorAction SilentlyContinue
Get-NetFirewallRule | Where-Object { $_.DisplayName -match "Remote Assistance" } | Disable-NetFirewallRule -ErrorAction SilentlyContinue

Write-Host "Firewall configured. Use Get-NetFirewallProfile and Get-NetFirewallRule to verify."
