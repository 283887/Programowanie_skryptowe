#Sprawdzanie hasła

$wprowadzony_uzytkownik = Read-Host "Login"
$wprowadzone_haslo = Read-Host "Podaj haslo:" Mask-Input 

if($wprowadzony_uzytkownik -eq "Admin" -and $wprowadzone_haslo -eq "Password"){
Write-Host "Logowanie udane!"
}
else

{
Write-Host "Niepoprawny login lub haslo"
}