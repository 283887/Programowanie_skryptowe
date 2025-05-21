#!/bin/bash

# SKRYPT WYKONUJE KOPIE ZAPOSOWĄ OKREŚLONYCH PLIKÓW
# PRZESYŁA KOPIĘ NA ZDALNY SERWER FTP W OKREŚLONYM KATALOGU
# POSIADA TEŻ FUNKCJĘ ARCHIWIZACJI I KOMPRESJI PLIKÓW PRZED WYSŁANIEM


# pobranie pliku do przesłania, sprawdzenie czy istnieje
read -p "Podaj nazwę pliku do wysłania na serwer: " PLIK
if [[ -e "$PLIK" ]]; then
	echo "Plik istnieje, przechodzę do wykonania kopii zapasowej ..."
else
	echo "ERROR: Plik/katalog który podajesz nie istnieje"
	exit 1
fi

# wykonanie kopii zapasowej z unikalną nazwą od daty utworzenia
mkdir -p "kopie_zapasowe"
cp -v "$PLIK" "kopie_zapasowe/$(basename "$PLIK")_$(date +%Y%m%d%H%M%S)"

# archiwizacja i kompresja pliku przed wysłaniem
PLIK_DO_WYSLANIA="${PLIK}_$(date +%Y%m%d%H%M%S).tar.gz"
tar -czf "$PLIK_DO_WYSLANIA" "$PLIK"


# przesłanie na serwer FTP
IP="127.0.0.1"
USER="user" #w tym miejscu wpisz nazwę swojego użytkownika
PASS="secret_password" #w tym miejscu podaj swoje hasło
KAT_NA_SERWERZE="."

echo "Przesyłam plik na serwer FTP ..."
ftp -inv "$IP" <<EOF
user $USER $PASS
cd $KAT_NA_SERWERZE
put "$PLIK_DO_WYSLANIA"
bye

EOF

# sprawdzenie czy przesłanie się udało
if [[ $? -eq 0 ]]; then
    echo "Plik został pomyślnie przesłany na FTP jako '$PLIK_DO_WYSLANIA'."
else
    echo "Ups cos poszło nie tak :( ..."
    exit 2
fi
