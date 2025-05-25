#!/bin/bash

# SKRYPT WYSZUKUJĄCY INFORMACJE GEOLOKALIZACYJNE Z PLIKU


# deklarujemy zdjęcie z którego wyszukamy informacje
zdjecie="zdjecie.JPG"

# sprawdzamy czy plik istnieje
if [ ! -f "$zdjecie" ]; then
	echo "Plik nie istnieje"
	exit -1
fi

# używając exiftool wypisujemy co chcemy
echo "szerokosc geograficzna: $(exiftool  -GPSLatitude -s3 "$zdjecie")"
echo "dlugosc geograficzna: $(exiftool  -GPSLongitude -s3 "$zdjecie")"

