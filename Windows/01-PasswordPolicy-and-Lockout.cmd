:: Run as Administrator
:: Password policy
net accounts /minpwlen:11 /maxpwage:60 /minpwage:1 /uniquepw:5

:: Account lockout (approximate via acct lockout policies)
net accounts /lockoutthreshold:5
:: net accounts doesn't set duration; set via secpol or registry if needed
echo Password and basic lockout policy applied.
pause
