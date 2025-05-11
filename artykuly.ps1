# skrypt do wyszukiwania artykułów z portali informacyjnych za pomocą NEWSAPI

#pobranie tematu i dat
$temat = Read-Host -Prompt "Podaj temat do wyszukania artykułu"
$klucz_api = "tutaj podaj swój klucz"
$data1 = Read-Host -Prompt "Podaj datę od której chcesz poznać artykuły (format yyyy-mm-dd)"
$data2 = Read-Host -Prompt "Podaj datę do której chcesz poznać artykuły (format yyyy-mm-dd)"

#wprowadzenie danych do url
$url = "https://newsapi.org/v2/everything?q=$temat&from=$data1&to=$data2&sortBy=popularity&apiKey=$klucz_api"

#sprawdzamy datę, bo strona pozwala bezpłatnie tylko do miesiąc temu pobierać artykuły
$dzis = Get-Date
$maxData = $dzis.AddMonths(-1)

if (([datetime]$data1 -lt $maxData) -or ([datetime]$data2 -lt $maxData)) {
    Write-Host "BŁĄD: Można pobierać artykuły tylko z ostatnich 30 dni!"
    exit
}

#pobranie odpowiedzi z api
$response = Invoke-RestMethod -Uri $url -Method Get

Write-Host "`n"

#wypisanie wyników
$response.articles | ForEach-Object {
    Write-Host "Tytuł: $($_.title)"
    Write-Host "Autor: $($_.author)"
    Write-Host "Źródło: $($_.source.name)"
    Write-Host "Data publikacji: $($_.publishedAt)"
    Write-Host "Link: $($_.url)"
    Write-Host "`n******************************************`n"

}