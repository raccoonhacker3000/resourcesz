$reportDir = "$env:USERPROFILE\CP_Reports"
New-Item -Path $reportDir -ItemType Directory -Force | Out-Null

# Netstat
netstat -aon > "$reportDir\netstat.txt"

# List users and groups
Get-LocalUser | Format-Table Name,Enabled,LastLogon | Out-File "$reportDir\localusers.txt"
Get-LocalGroup | ForEach-Object { $_.Name; Get-LocalGroupMember -Group $_.Name | Out-String } | Out-File "$reportDir\localgroups.txt"

# Audit policy
auditpol /get /category:* > "$reportDir\auditpol.txt"

# Firewall status
Get-NetFirewallProfile | Format-Table Name,Enabled,DefaultInboundAction,NotifyOnListen | Out-File "$reportDir\firewall.txt"

Write-Host "Reports saved to $reportDir"
