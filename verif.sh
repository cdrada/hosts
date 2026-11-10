#!/bin/bash

verifica_ip() {
    nume="$1"
    ip="$2"
    dns="$3"

    rezultat=$(nslookup "$nume" "$dns" | awk '/^Name:/ {found=1; next} found && /^Address: / {print $2}')

    if ! echo "$rezultat" | grep -Fxq "$ip"; then
        echo "Bogus IP for $nume in /etc/hosts!"
    fi
}

cat /etc/hosts | while read ip nume
do
    if [[ "$ip" == \#* || -z "$ip" ]]; then
        continue
    fi

    verifica_ip "$nume" "$ip" "8.8.8.8"
done
