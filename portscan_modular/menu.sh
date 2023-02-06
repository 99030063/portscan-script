#!/bin/bash

clear
PS3='Maak uw keuze: '
options=("Portscan WAN IPv4" "Portscan WAN IPv6" "Portscan WAN IPv4 and IPv6" "Portscan LAN IPv4" "Portscan LAN IPv6" "Portscan LAN IPv4 and IPv6" "Portscan WAN+LAN IPv4 + IPv6" "Rennen en wegwezen")
select opt in "${options[@]}"
do
    case $opt in
        "Portscan WAN IPv4")
            echo "Wat is het IPv4 adres?"
            read IPv4
            echo "Welke poorten wil je scannen? (Enter = 1-65535)"
            read Ports
            ./portscan_IPv4_WAN.sh $IPv4 $Ports
            break
            ;;
        "Portscan WAN IPv6")
            echo "Wat is het IPv6 adres?"
            read IPv6
            echo "Welke poorten wil je scannen? (Enter = 1-65535)"
            read Ports
            ./portscan_IPv6_WAN.sh $IPv6 $Ports
            break
            ;;
        "Portscan WAN IPv4 and IPv6")
            echo "Wat is het IPv4 adres?"
            read IPv4
            echo "Wat is het IPv6 adres?"
            read IPv6
            echo "Welke poorten wil je scannen? (Enter = 1-65535)"
            read Ports
            ./portscan_IPv4-IPv6_WAN.sh $IPv4 $IPv6 $Ports
            break
            ;;
        "Portscan LAN IPv4")
            echo "Wat is het IPv4 adres?"
            read IPv4
            echo "Welke poorten wil je scannen? (Enter = 1-65535)"
            read Ports
            ./portscan_IPv4_LAN.sh $IPv4 $Ports
            break
            ;;
        "Portscan LAN IPv6")
            echo "Wat is het IPv6 adres?"
            read IPv6
            echo "Welke poorten wil je scannen? (Enter = 1-65535)"
            read Ports
            ./portscan_IPv6_LAN.sh $IPv6 $Ports
            break
            ;;
        "Portscan LAN IPv4 and IPv6")
            echo "Wat is het IPv4 adres?"
            read IPv4
            echo "Wat is het IPv6 adres?"
            read IPv6
            echo "Welke poorten wil je scannen? (Enter = 1-65535)"
            read Ports
            ./portscan_IPv4-IPv6_LAN.sh $IPv4 $IPv6 $Ports
            break
            ;;
        "Portscan WAN+LAN IPv4 + IPv6")
            echo "Wat is het IPv4 LAN adres?"
            read IPv4LAN
            echo "Wat is het IPv6 LAN adres?"
            read IPv6LAN
            echo "Wat is het IPv4 WAN adres?"
            read IPv4WAN
            echo "Wat is het IPv6 WAN adres?"
            read IPv6WAN
            echo "Welke poorten wil je scannen? (Enter = 1-65535)"
            read Ports
            ./portscan_IPv4-IPv6_WAN_LAN.sh $IPv4LAN $IPv6LAN $IPv4WAN $IPv6WAN $Ports
            break
            ;;
        "Rennen en wegwezen")
            break
            ;;
        *) echo "ongeldige optie $REPLY";;
    esac
done