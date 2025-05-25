#!/bin/bash

# SKRYPT USUWAJĄCY METADANE Z PLIKU
# CZYSTY PLIK ZOSTAJE ZAPISANY JAKO ODRĘBNY PLIK


# zmienna do pliku jako argument skryptu
zdjecie="$1"

# sprawdzamy czy plik istnieje
if [ ! -f "$zdjecie" ]; then
	echo "Plik nie istnieje"
	exit 1
fi
# nowa zmienna dla zdjecia bez metadanych
nazwa_bez_rozszerzenia="${zdjecie%.*}"
rozszerzenie="${zdjecie##*.}"
czyste="${nazwa_bez_rozszerzenia}_wyczyszczone.${rozszerzenie}"


# usuwanie metadanych i zapis do nowego pliku

exiftool -all= -o "$czyste" "$zdjecie"
echo "Zdjęcie zostało wyczyszczone i zapisane jako $czyste"

