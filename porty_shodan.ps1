# program służący do znajdowania otwartych portów dla danego adresu IP przez API shodana

#pobranie adresu IP i klucza api
$adres = Read-Host -Prompt "Podaj adres IP dla którego chcesz sprawdzić porty"
$klucz_api = "tutaj podaj swój klucz"


#wprowadzenie zmiennych do url
$url = "https://api.shodan.io/shodan/host/" + $adres + "?key=" + $klucz_api

#pobranie odpowiedzi z api
$response = Invoke-RestMethod -Uri $url -Method Get

Write-Host "`n"

#interpretacja odpowiedzi
$response.data | ForEach-Object {

    Write-Host "Port: $($_.port)"
    Write-Host "Usługa: $($_._shodan.module) `n"

}
