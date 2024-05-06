param (
    [Parameter(Mandatory=$false)]
    [System.Management.Automation.PSCredential]$Credential,
    [Parameter(Mandatory=$false)]
    [string]$Serveradress 
    
)


[string]$defaultserver= "Example.com"



####Vorbereitung

# Überprüfen, ob die Variable $credential leer ist
if (-not $credential) {
    # Wenn $credential leer ist, fragen Sie nach den Anmeldeinformationen
    $credential = Get-Credential -Message "Bitte geben Sie einen Baramundi-Berechtigen Benutzer an"
}

if (-not $Serveradress){
    $Serveradress = $defaultserver
}

# Überprüfen Sie, ob Sie PowerShell 7 oder höher verwenden
if ($PSVersionTable.PSVersion.Major -ge 7) {
    # In PowerShell 7 oder höher verwenden Sie Get-CimInstance
    $domain = (Get-CimInstance -ClassName Win32_ComputerSystem).Domain
} else {
    # In älteren Versionen von PowerShell verwenden Sie Get-WmiObject
    $domain = (Get-WmiObject -Class Win32_ComputerSystem).Domain
}

# Extrahieren Sie den Benutzernamen aus dem $credential-Objekt
$username = $credential.UserName

# Überprüfen Sie, ob der Benutzername eine Domäne enthält
if ($username -notmatch "@") {
    # Wenn nicht, fügen Sie die Domäne hinzu
    $username = "$username@$domain"
}

# Aktualisieren Sie das $credential-Objekt mit dem neuen Benutzernamen
$credential = New-Object System.Management.Automation.PSCredential($username, $credential.Password)





# Überprüfen, ob das Modul bConnect installiert ist
if (-not (Get-Module -ListAvailable -Name bConnect)) {
    # Wenn das Modul nicht installiert ist, installieren Sie es
    try {
        Install-Module -Name bConnect -Scope CurrentUser -ErrorAction Stop
    } catch {
        Write-Error "Die Installation des Moduls bConnect ist fehlgeschlagen: $_"
        return
    }
}

# Überprüfen, ob das Modul erfolgreich installiert wurde
if (-not (Get-Module -ListAvailable -Name bConnect)) {
    Write-Error "Das Modul bConnect konnte nicht gefunden werden. Die Installation ist möglicherweise fehlgeschlagen."
} else {
    # Das Modul importieren
    Import-Module -Name bConnect
}


