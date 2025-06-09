# informacje o systemie

$computer = $Env:COMPUTERNAME

function akt_data{
$data = Get-Date
Write-Host "Aktualna data komputera $computer : $data" 
}

function wersja_systemu{
$wersja = (Get-ComputerInfo).WindowsProductName
Write-Host "Wersja systemu komputera $computer : $wersja" 
}

function nazwa{
$user = $env:USERNAME
Write-Host "Użytkownik komputera $computer : $user"
}

function ipadres{
$adres = (Get-NetIPAddress| Where-Object{$_.InterfaceAlias -eq "Ethernet" -and $_.AddressFamily -eq "IPv4"}).IPAddress
Write-Host "Adres Ip komputera $computer : $adres"
}

akt_data
wersja_systemu
nazwa
ipadres
