# SKRYPT SKANUJĄCY WYBRANE PORTY NA SERWERZE
# SZUKA OTWARTYCH PORTÓW TCP

# importujemy bibliotekę do komunikacji sieciowej
import socket

# funkcja skanująca porty (adres, zakres portów)
def scan_ports(host, port_range):
    # przechodzimy przez każdy port z zakresu
    for port in port_range:
        # tworzymy gniazdo do komunikacji TCP
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.settimeout(0.5) # czas oczekiwania na odpowiedź
            result = s.connect_ex((host, port))
            if result == 0: # sprawdzamy odpowiedź, 0 oznacza port otwarty
                print(f"Port {port} otwarty")
            else:
                print(f"Port {port} zamknięty")

# zastosowanie funkcji dla danego adresu i portów
scan_ports("adres_ip4_serwera_ktory_testujemy", range(120, 140))