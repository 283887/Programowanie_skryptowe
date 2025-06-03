# PROGRAM KTÓRY SZYFRUJE ZADANY PLIK TEKSTOWY algorytmem xor 


# FUNKCJA SZYFRUJĄCA PLIK ALGORYTMEM XOR
def xor_encrypt_file(plik: str, output_plik: str, klucz: str):
    key_bytes = klucz.encode()

    # ZCZYTANIE DANYCH Z PLIKU
    with open(plik, 'rb') as f:
        data = f.read()
    # SZYFROWANIE PLIKU
    encrypted = bytearray()
    for i in range(len(data)):
        encrypted.append(data[i] ^ key_bytes[i % len(key_bytes)])

    # WYPISANIE ZASZYFROWANYCH DANYCH DO PLIKU WYJŚCIOWEGO
    with open(output_plik, 'wb') as f:
        f.write(encrypted)

    print(f"Plik zaszyfrowany zapisano jako: {output_plik}")

# PĘTLA 'GŁÓWNA' -> INTERAKTUJEMY Z UŻYTKOWNIKIEM
if __name__ == "__main__":
    print("SZYFROWANIE PLIKU XOR")

    # prosimy użytkownika o plik do zaszfrowania
    # oraz o klucz według którego XOR zaszyfruje plik
    sciezka = input("Podaj nazwę pliku do zaszyfrowania: ")
    key = input("Podaj hasło (klucz szyfrowania): ")

    output_file = sciezka + ".xor"
    xor_encrypt_file(sciezka, output_file, key)