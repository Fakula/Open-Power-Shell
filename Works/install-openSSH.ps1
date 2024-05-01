# Überprüfen Sie, ob der OpenSSH-Client bereits installiert ist
if ((Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH.Client*').State -eq 'Installed') {
    Write-Output "OpenSSH-Client ist bereits installiert."
} else {
    # Installieren Sie den OpenSSH-Client
    Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
    # Überprüfen Sie, ob die Installation erfolgreich war
    if ((Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH.Client*').State -eq 'Installed') {
        Write-Output "OpenSSH-Client wurde erfolgreich installiert."
    } else {
        Write-Output "Fehler bei der Installation des OpenSSH-Clients."
    }
}
