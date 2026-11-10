#!/bin/bash

cat /etc/hosts | while read ip nume
do
    if [[ "$ip" == \#* || -z "$ip" ]]; then
        continue
    fi

    rezultat=$(nslookup "$nume" | awk '/^Name:/ {found=1; next} found && /^Address: / {print $2}')

    if ! echo "$rezultat" | grep -Fxq "$ip"; then
        echo "Bogus IP for $nume in /etc/hosts!"
    fi
done
