function Manage-bConnectEndpoint {
    param (
        [string]$ComputerName,
        [string]$FilePath
    )

    # Suche nach dem Endpoint
    $endpoints = Search-bConnectEndpoint -Term "WindowsClient*"

    # Überprüfe, ob Endpoints gefunden wurden
    if ($endpoints -is [bool] -and $endpoints -eq $true) {
        Write-Host "Keine Endpoints gefunden."
    } elseif ($endpoints) {
        # Gehe durch jeden gefundenen Endpoint
        foreach ($endpoint in $endpoints) {
            # Exportiere die Endpoint-Daten als XML an die angegebene Datei
            $endpoint | Export-Clixml -Path $FilePath -Append

            # Entferne den Endpoint aus der Datenbank
            Remove-bConnectEndpoint -EndpointGuid $endpoint.Guid
        }
    } else {
        Write-Host "Ein unerwarteter Fehler ist aufgetreten."
    }
}
