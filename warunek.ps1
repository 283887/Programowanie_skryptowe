# Sprawdzenie liczby 

[int]$liczba = Read-Host -Prompt "Podaj liczbę do sprawdzenia: "

if($liczba -gt 10){

Write-Host "Liczba jest większa od 10"

}
elseif($liczba -lt 10){

Write-Host "Liczba jest mniejsza od 10"

}
else{

Write-Host "Liczba jest równa 10"

}