# Starten Sie PowerShell als Administrator und führen Sie diesen Code aus

# Führt den SFC-Scan aus
Write-Output "Starte SFC-Scan..."
sfc /scannow

# Speichert die Ergebnisse in einer Textdatei
Write-Output "Speichern der SFC-Scan-Ergebnisse..."
$SFCResults = Get-WinEvent -ProviderName "Microsoft-Windows-Wininit" | Where-Object {$_.Message -match "sfc"} | Select-Object -First 1
$SFCResults.Message | Out-File -FilePath "$env:USERPROFILE\Desktop\SFCResults.txt"

Write-Output "Fertig! Die Ergebnisse des SFC-Scans finden Sie auf Ihrem Desktop in der Datei 'SFCResults.txt'."
