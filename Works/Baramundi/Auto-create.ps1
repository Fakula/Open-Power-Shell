function New-bConnectEndpoints {
    param (
        [Parameter(Mandatory=$true)]
        [psobject[]]$computerList
    )

    foreach ($computer in $computerList) {
        # Extrahieren Sie den Rechnernamen und die MAC-Adresse aus dem aktuellen Objekt
        $computerName = $computer.Name
        $macAddress = $computer.Mac

        # Erstellen Sie einen neuen Endpoint für den aktuellen Computer
        New-bConnectEndpoint -Type WindowsEndpoint -DisplayName $computerName -HostName $computerName -PrimaryMac $macAddress
    }
}
