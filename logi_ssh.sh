#!/bin/bash

# SKRYPT DO MONITOROWANIA LOGÓW POŁĄCZEŃ SSH
# JEŚLI WYKRYJE PODEJRZANE AKTYWNOSCI WYGENERUJE RAPORT
# NP. NIEUDANE LOGOWANIE


#zmienna do raportu
RAPORT="raport.txt"

#liczymy nieudane próby
PROBY_1=$(journalctl -u ssh.service | grep -c "Failed password")
PROBY_2=$(journalctl -u ssh.service | grep -c "authentication failure")
PROBY_3=$(journalctl -u ssh.service | grep -c "Invalid user")

# wypisanie podejrzanych aktywności do raportu
if [[ $PROBY_1 -gt 0 || $PROBY_2 -gt 0 || $PROBY_3 -gt 0 ]]
then
    echo "RAPORT Z LOGÓW SSH" > "$RAPORT"
    echo "Data: $(date)" >> "$RAPORT"
    echo "" >> "$RAPORT"

    echo "Failed password: $PROBY_1 razy" >> "$RAPORT"
    journalctl -u ssh.service | grep "Failed password" >> "$RAPORT"
    echo "" >> "$RAPORT"

    echo "Authentication failure: $PROBY_2 razy" >> "$RAPORT"
    journalctl -u ssh.service | grep "authentication failure" >> "$RAPORT"
    echo "" >> "$RAPORT"

    echo "Invalid user: $PROBY_3 razy" >> "$RAPORT"
    journalctl -u ssh.service | grep "Invalid user" >> "$RAPORT"
    echo "" >> "$RAPORT"

echo "Zaktualizowano raport, wynik znajduje sie w pliku $RAPORT"
fi
 
