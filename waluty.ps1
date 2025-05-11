# skrypt sprawdzający kurs waluty bieżący oraz z poprzednich 5 dni

#sformatowanie daty aby pasowała do api
$dzisiaj = (Get-Date).ToString("yyyy-MM-dd")
$od_kiedy = (Get-Date).AddDays(-5).ToString("yyyy-MM-dd")

#pobranie rodziaju waluty od użytkownika
$waluta = Read-Host -Prompt "Podaj walutę, aby zobaczyć jej kurs z ostatnich dni"

#zapisanie linku oraz odpowiedzi do zmiennych 
$url = "https://api.nbp.pl/api/exchangerates/rates/A/$waluta/$od_kiedy/$dzisiaj/"

$response = Invoke-RestMethod -Uri $url -Method Get

#pobranie kategorii
$rodzaj = $response.currency
Write-Host "WYŚWIETLANIE KURSU DLA WALUTY: $rodzaj `n"

#interpretacja odpowiedzi -> z odpowiedzi bierzemy datę oraz kurs
#sprawdzamy też czy w jakimś dniu nie ma kursu

for ($i = 5; $i -ge 0; $i--) {

        $data = (Get-Date).AddDays(-$i).ToString("yyyy-MM-dd")
        
        # Szukaj rekordu dla tej daty
        $kurs = $response.rates | Where-Object { $_.effectiveDate -eq $data }

        if ($kurs) {
            Write-Host "Data: $data, Kurs: $($kurs.mid)"
        } 

        else {
            Write-Host "UWAGA! BRAK DANYCH Z DNIA: $data"
        }
    }

Write-Host "`n"

#obliczanie różnicy między datami
Write-Host "RÓŻNICE MIĘDZY KOLEJNYMI KURSAMI:"

$poprzedni = $null

foreach ($kurs in $response.rates) {
    $data = $kurs.effectiveDate
    $mid = $kurs.mid

    if ($poprzedni -ne $null) {
        $roznica = [math]::Round($mid - $poprzedni.mid, 4)
        Write-Host "między $($poprzedni.effectiveDate) a $data : $roznica"
    }

    $poprzedni = $kurs
}