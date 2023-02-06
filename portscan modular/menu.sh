#!/bin/bash

clear
PS3='Maak uw keuze: '
options=("Portscan WAN IPv4" "Portscan WAN IPv6" "Portscan WAN IPv4 and IPv6" "Rennen en wegwezen")
select opt in "${options[@]}"
do
    case $opt in
        "Portscan WAN IPv4")
            echo "Wat is het IPv4 adres?"
            read IPv4
            echo "Welke poorten wil je scannen? (Enter = 1-65535)"
            read Ports
            ./portscan_IPv4.sh $IPv4 $Ports
            break
            ;;
        "Portscan WAN IPv6")
            echo "Wat is het IPv6 adres?"
            read IPv6
            echo "Welke poorten wil je scannen? (Enter = 1-65535)"
            read Ports
            ./portscan_IPv6.sh $IPv6 $Ports

            break
            ;;
        "Portscan WAN IPv4 and IPv6")
            echo "Wat is het IPv4 adres?"
            read IPv4
            echo "Wat is het IPv6 adres?"
            read IPv6
            echo "Welke poorten wil je scannen? (Enter = 1-65535)"
            read Ports
            ./portscan_IPv4-IPv6.sh $IPv4 $IPv6 $Ports
            break
            ;;
        "Rennen en wegwezen")
            break
            ;;
        *) echo "ongeldige optie $REPLY";;
    esac
done