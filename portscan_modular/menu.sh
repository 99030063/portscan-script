#!/bin/bash

function valid_ip4()
{
    local  ip=$1
    local  stat=1

    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
            && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    fi
    return $stat
}

function valid_ip6()
{
    [[ $# = 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 2

    declare ip="${1}"
    declare re="^(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|\
([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|\
([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|\
([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|\
:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|\
::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|\
(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|\
(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))$"

    [[ "${ip}" =~ $re ]] && return 0 || return 1

}

clear
PS3='Maak uw keuze: '
options=("Portscan WAN IPv4" "Portscan WAN IPv6" "Portscan WAN IPv4 and IPv6" "Portscan LAN IPv4" "Portscan LAN IPv6" "Portscan LAN IPv4 and IPv6" "Portscan WAN+LAN IPv4 + IPv6" "Rennen en wegwezen")
select opt in "${options[@]}"
do
    case $opt in
        "Portscan WAN IPv4")
            echo "Wat is het IPv4 adres?"
            read IPv4
            valid_ip4 $IPv4
            if valid_ip4 $IPv4; then stat='good4'; else stat='bad4'; fi
            if [ $stat == 'bad4' ]
            then
                echo "Invalid IP4 address"
                break;
            fi
            echo "Welke poorten wil je scannen? (Enter = 1-65535)"
            read Ports
            ./portscan_IPv4_WAN.sh $IPv4 $Ports
            break
            ;;
        "Portscan WAN IPv6")
            echo "Wat is het IPv6 adres?"
            read IPv6
            valid_ip6 $IPv6
            if valid_ip6 IPv6; then stat='good6'; else stat='bad6'; fi
            if [ $stat == 'bad6' ]
            then
                echo 'Invalid IP6 address'
                break;
            fi
            echo "Welke poorten wil je scannen? (Enter = 1-65535)"
            read Ports
            ./portscan_IPv6_WAN.sh $IPv6 $Ports
            break
            ;;
        "Portscan WAN IPv4 and IPv6")
            echo "Wat is het IPv4 adres?"
            read IPv4
            valid_ip4 $IPv4
            if valid_ip4 $IPv4; then stat='good4'; else stat='bad4'; fi
            if [ $stat == 'bad4' ]
            then
                echo "Invalid IP4 address"
                break;
            fi
            echo "Wat is het IPv6 adres?"
            read IPv6
            valid_ip6 $IPv6
            if valid_ip6 IPv6; then stat='good6'; else stat='bad6'; fi
            if [ $stat == 'bad6' ]
            then
                echo 'Invalid IP6 address'
                break;
            fi
            echo "Welke poorten wil je scannen? (Enter = 1-65535)"
            read Ports
            ./portscan_IPv4-IPv6_WAN.sh $IPv4 $IPv6 $Ports
            break
            ;;
        "Portscan LAN IPv4")
            echo "Wat is het IPv4 adres?"
            read IPv4
            valid_ip4 $IPv4
            if valid_ip4 $IPv4; then stat='good4'; else stat='bad4'; fi
            if [ $stat == 'bad4' ]
            then
                echo "Invalid IP4 address"
                break;
            fi
            echo "Welke poorten wil je scannen? (Enter = 1-65535)"
            read Ports
            ./portscan_IPv4_LAN.sh $IPv4 $Ports
            break
            ;;
        "Portscan LAN IPv6")
            echo "Wat is het IPv6 adres?"
            read IPv6
            valid_ip6 $IPv6
            if valid_ip6 $IPv6; then stat='good6'; else stat='bad6'; fi
            if [ $stat == 'bad6' ]
            then
                echo 'Invalid IP6 address'
                break;
            fi
            echo "Welke poorten wil je scannen? (Enter = 1-65535)"
            read Ports
            ./portscan_IPv6_LAN.sh $IPv6 $Ports
            break
            ;;
        "Portscan LAN IPv4 and IPv6")
            echo "Wat is het IPv4 adres?"
            read IPv4
            valid_ip4 $IPv4
            if valid_ip4 $IPv4; then stat='good4'; else stat='bad4'; fi
            if [ $stat == 'bad4' ]
            then
                echo "Invalid IP4 address"
                break;
            fi
            echo "Wat is het IPv6 adres?"
            read IPv6
            valid_ip6 $IPv6
            if valid_ip6 $IPv6; then stat='good6'; else stat='bad6'; fi
            if [ $stat == 'bad6' ]
            then
                echo 'Invalid IP6 address'
                break;
            fi
            echo "Welke poorten wil je scannen? (Enter = 1-65535)"
            read Ports
            ./portscan_IPv4-IPv6_LAN.sh $IPv4 $IPv6 $Ports
            break
            ;;
        "Portscan WAN+LAN IPv4 + IPv6")
            echo "Wat is het IPv4 LAN adres?"
            read IPv4LAN
            valid_ip4 $IPv4LAN
            if valid_ip4 $IPv4LAN; then stat='good4'; else stat='bad4'; fi
            if [ $stat == 'bad4' ]
            then
                echo "Invalid IP4 address"
                break;
            fi
            echo "Wat is het IPv6 LAN adres?"
            read IPv6LAN
            valid_ip6 $IPv6LAN
            if valid_ip6 $IPv6LAN; then stat='good6'; else stat='bad6'; fi
            if [ $stat == 'bad6' ]
            then
                echo 'Invalid IP6 address'
                break;
            fi
            echo "Wat is het IPv4 WAN adres?"
            read IPv4WAN
            valid_ip4 $IPv4WAN
            if valid_ip4 $IPv4WAN; then stat='good4'; else stat='bad4'; fi
            if [ $stat == 'bad4' ]
            then
                echo echo "Invalid IP4 address"
                break;
            fi
            echo "Wat is het IPv6 WAN adres?"
            read IPv6WAN
            valid_ip6 $IPv6WAN
            if valid_ip6 $IPv6WAN; then stat='good6'; else stat='bad6'; fi
            if [ $stat == 'bad6' ]
            then
                echo 'Invalid IP6 address'
                break;
            fi
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