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

# # ip validation function IPv4
# function valid_ip()
# {
#     local  ip=$1
#     local  stat=1

#     if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
#         OIFS=$IFS
#         IFS='.'
#         ip=($ip)
#         IFS=$OIFS
#         [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
#             && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
#         stat=$?
#     fi
#     return $stat
# }

# # If run directly, execute some tests.
# if [[ "$(basename $0 .sh)" == 'valid_ip' ]]; then
#     ips='
#         4.2.2.2
#         a.b.c.d
#         192.168.1.1
#         0.0.0.0
#         255.255.255.255
#         255.255.255.256
#         192.168.0.1
#         192.168.0
#         1234.123.123.123
#         '
#     for ip in $ips
#     do
#         if valid_ip $ip; then stat='good'; else stat='bad'; fi
#         printf "%-20s: %s\n" "$ip" "$stat"
#     done
# fi