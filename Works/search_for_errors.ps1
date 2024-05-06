# Erstellen Sie ein neues PowerShell-Objekt für das Ereignisprotokoll
$eventLog = New-Object System.Diagnostics.Eventing.Reader.EventLogReader("Application")

# Durchsuchen Sie die Ereignisse
while ($true) {
    $event = $eventLog.ReadEvent()
    if ($null -eq $event) { break }

    # Überprüfen Sie, ob das Ereignis ein Fehler ist und ob es sich auf einen Absturz bezieht
    if ($event.LevelDisplayName -eq "Fehler" -and $event.Message -like "*crash*") {
        # Geben Sie die Details des Ereignisses aus
        Write-Output ("Event ID: " + $event.Id)
        Write-Output ("Event Level: " + $event.LevelDisplayName)
        Write-Output ("Event Message: " + $event.Message)
        Write-Output ("-------------------------")
    }
}
