#wypisywanie wyników zadania do pliku

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

$out = ""

#interacja po danych z pliku
foreach ($item in $dane) {
    if ($item.GenerateReport -eq "True"){
    $out += "$($item.Component) -> $($wartosci[$item.Component])`n"
    }
}

#pobieramy date w formacie
$data = Get-Date -Format "yyyyMMdd-HHmmss"

#łączymy z nazwą pliku
$nazwa_pliku = "ComputerReport_$data.txt"

#tworzymy ściezke dla pliku
$path = "C:\Users\Admin\Documents\$nazwa_pliku"

#wypisanie do pliku
$out | Out-File -FilePath $path

#ostateczny komunikat
Write-Host "Raport został zapisany w pliku: $path"
