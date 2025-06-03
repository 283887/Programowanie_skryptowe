#  SKRYPT PODPISUJĄCY CYFROWO PLIK (HMAC SHA256)

# importujemy biblioteki
import hmac
import hashlib
import sys

# FUNKCJA PODPISUJĄCA CYFROWO PLIK 
def sign_file(sciezka, klucz):
    # otwarcie i podpisanie pliku
    try:
        with open(sciezka, 'rb') as f:
            file_data = f.read()
        podpis = hmac.new(klucz.encode(), file_data, hashlib.sha256).hexdigest()
        return podpis
    # obsługa błędu: nie znaleziono pliku 
    except FileNotFoundError:
        print("Plik nie został znaleziony :(")
        sys.exit(1)

# PĘTLA GŁÓWNA Z WYKORZYSTANIEM FUNKCJI
if __name__ == '__main__':

    # prosimy o wprowadzenie danych
    print("Cyfrowe podpisywanie pliku (HMAC SHA256)")
    file_path = input("Podaj nazwę pliku do podpisania: ").strip()
    secret_key = input("Podaj klucz tajny: ").strip()
 
    #podpisanie pliku i komunikat dla użytkownika
    podpis = sign_file(file_path, secret_key)
    print(f"\nPodpis pliku: {podpis}")
