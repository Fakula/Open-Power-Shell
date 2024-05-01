function Flatten-Object {
    param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [PSObject]$InputObject
    )

    process {
        $hash = @{}
        foreach ($property in $InputObject.PSObject.Properties) {
            if ($property.Value -is [PSCustomObject]) {
                $flattenedSubProperties = Flatten-Object -InputObject $property.Value
                foreach ($subProperty in $flattenedSubProperties.PSObject.Properties) {
                    $hash["$($property.Name)_$($subProperty.Name)"] = $subProperty.Value
                }
            } else {
                $hash[$property.Name] = $property.Value
            }
        }
        [PSCustomObject]$hash
    }
}

# Beispiel für die Verwendung
$objArray = @(
    @{
        Name = "Objekt1"
        Eigenschaft1 = "Wert1"
        UnterEigenschaften = @{
            UnterEigenschaft1 = "UnterWert1"
            UnterEigenschaft2 = @{
                UnterUnterEigenschaft1 = "UnterUnterWert1"
            }
        }
    },
    @{
        Name = "Objekt2"
        Eigenschaft1 = "Wert2"
        UnterEigenschaften = @{
            UnterEigenschaft1 = "UnterWert3"
            UnterEigenschaft2 = "UnterWert4"
        }
    }
)

$objArray | ForEach-Object { $_ | Flatten-Object }
