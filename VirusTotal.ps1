# Program sprawdzający czy plik jest bezpieczny

#1 -> podanie klucza API i ścieżki do pliku
$klucz_api = "podaj_wsoj_klucz"
$plik = "C:\Users\Admin\Documents\plik_testowy.txt"

#2 -> obliczenie SHA256 i wypisanie go
$hasz = Get-FileHash -Path "$plik" -Algorithm SHA256
$hasz.Hash

#3 -> wysyłamy zapytanie do VIRUSTOTAL
$url = "https://www.virustotal.com/api/v3/files/$hasz"

$headers = @{
    "x-apikey" = $klucz_api
}
$response = Invoke-RestMethod -Uri $url -Headers $headers -Method GET