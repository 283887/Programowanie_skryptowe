#!/bin/bash


# SKRYPT KTÓRY AUTOMATYCZNIE LOGUJE SIĘ NA ZDALNY SERWER PRZY UŻYCIU SSH
# WYKONUJE POLECENIA: LISTOWANIE PLIKÓW I PROCESÓW
# DANE WYPISUJE DO PLIKU: wyniki.txt


# ustalamy dane do logowania przez ssh i plik do wyników
plik_z_wynikami="wyniki.txt"

user="user" # tutaj podaj nazwę swojego użytkownika
adres_hosta="127.0.0.1"

# komendy do wykonania na serwerze (lista plików i procesów)
KOMENDY="echo 'LISTA PLIKÓW'
ls -la
echo ''

echo 'LISTA PROCESÓW'
ps aux"


# połącznie przez ssh, wykonanie komend i wypisanie do pliku wyniki.txt
ssh "$user@$adres_hosta" "$KOMENDY" > "$plik_z_wynikami"

# informacja o zakończeniu działania skryptu
echo "Polecenia wykonane :). Wyniki znajdują się w pliku $plik_z_wynikami" 
