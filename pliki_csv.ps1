#pobieranie danych z pliku csv

$sciezka = "Documents\zadanie6.csv"
$dane = Import-Csv -Path $sciezka -Delimiter ";"

#zbieramy wartosc z getcomputerinfo
$wartosci = @{

Computername = $env:COMPUTERNAME
Manufacturer = (Get-ComputerInfo).CsManufacturer
Model = (Get-ComputerInfo).CSModel
SerialNumber = (Get-ComputerInfo).BiosSeralNumber
CpuName = ((Get-ComputerInfo).CsProcessors).Name
RAM = [math]::Round((Get-ComputerInfo).CsTotalPhysicalMemory / 1GB)

}

#interacja po danych z pliku
foreach ($item in $dane) {
    if ($item.GenerateReport -eq "True"){
    Write-Output "$($item.Component) -> $($wartosci[$item.Component])"
    }
}
