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

CURRENTDIR=0
CMIP4=0
CMIP6=0
LANCMIP4=0
LANCMIP6=0
WANCMIP4=0
WANCMIP6=0
NOW=0
DIRNAME=0
FILENAME=0

function portscan_IPv4_WAN{
    CURRENTDIR=$pwd
    CMIP4=$1
    NOW=$(date +"%d_%m_%Y_%R")
    DIRNAME=$NOW-Portscan
    FILENAME=$CURRENTDIR/$DIRNAME/$NOW-portscan.txt
    if [ -z "$2" ]
    then
        PORTS=1-65535
    else
        PORTS=$2
    fi
    mkdir $DIRNAME
    echo -e "De ipv4 TCP WAN Portscan start nu voor het IPv4 adres $1 op de poorten $PORTS\n" | tee -a $FILENAME
    nmap -sS -p $PORTS -P0 $CMIP4 --max-retries=2 -T4 | tee -a $FILENAME
    echo -e "\n---------------------------------------------------------------------------------\n" | tee -a $FILENAME
    echo -e "De ipv4 UDP WAN Portscan start nu voor het IPv4 adres $1 op de poorten $PORTS\n" | tee -a $FILENAME
    nmap -sUV -p $PORTS -P0 $CMIP4 -T4 --version-intensity=2 --min-rate=1000 | tee -a $FILENAME
    echo -e "\n---------------------------------------------------------------------------------\n" | tee -a $FILENAME
    echo -e "De portscans zijn afgerond, de resultaten staan in de map $FILENAME"
}

function portscan_IPv6_WAN{
    CURRENTDIR=$pwd
    CMIP6=$1
    NOW=$(date +"%d_%m_%Y_%R")
    DIRNAME=$NOW-Portscan
    FILENAME=$CURRENTDIR/$DIRNAME/$NOW-portscan.txt
    if [ -z "$2" ]
    then
        PORTS=1-65535
    else
        PORTS=$2
    fi
    mkdir $DIRNAME
    echo -e "De ipv6 TCP WAN Portscan start nu voor het IPv6 adres $2 op de poorten $PORTS\n" | tee -a $FILENAME
    nmap -6 -sS -p $PORTS -P0 $CMIP6 -T4 --max-retries=2 -T4 | tee -a $FILENAME
    echo -e "\n---------------------------------------------------------------------------------\n" | tee -a $FILENAME
    echo -e "De ipv6 UDP WAN Portscan start nu voor het IPv6 adres $2 op de poorten $PORTS\n" | tee -a $FILENAME
    nmap -6 -sUV -p $PORTS -P0 $CMIP6 -T4 --version-intensity=2 --min-rate=1000  | tee -a $FILENAME
    echo -e "\n---------------------------------------------------------------------------------\n" | tee -a $FILENAME
    echo -e "De portscans zijn afgerond, de resultaten staan in de map $FILENAME"
}

function portscan_IPv4-IPv6_WAN{
    CURRENTDIR=$pwd
    CMIP4=$1
    CMIP6=$2
    NOW=$(date +"%d_%m_%Y_%R")
    DIRNAME=$NOW-Portscan
    FILENAME=$CURRENTDIR/$DIRNAME/$NOW-portscan.txt
    if [ -z "$3" ]
    then
        PORTS=1-65535
    else
        PORTS=$3
    fi
    mkdir $DIRNAME
    echo -e "De ipv4 TCP WAN Portscan start nu voor het IPv4 adres $1 op de poorten $PORTS\n" | tee -a $FILENAME
    nmap -sS -p $PORTS -P0 $CMIP4 --max-retries=2 -T4 | tee -a $FILENAME
    echo -e "\n---------------------------------------------------------------------------------\n" | tee -a $FILENAME
    echo -e "De ipv4 UDP WAN Portscan start nu voor het IPv4 adres $1 op de poorten $PORTS\n" | tee -a $FILENAME
    nmap -sUV -p $PORTS -P0 $CMIP4 -T4 --version-intensity=2 --min-rate=1000 | tee -a $FILENAME
    echo -e "\n---------------------------------------------------------------------------------\n" | tee -a $FILENAME

    echo -e "De ipv6 TCP WAN Portscan start nu voor het IPv6 adres $2 op de poorten $PORTS\n" | tee -a $FILENAME
    nmap -6 -sS -p $PORTS -P0 $CMIP6 -T4 --max-retries=2 -T4 | tee -a $FILENAME
    echo -e "\n---------------------------------------------------------------------------------\n" | tee -a $FILENAME
    echo -e "De ipv6 UDP WAN Portscan start nu voor het IPv6 adres $2 op de poorten $PORTS\n" | tee -a $FILENAME
    nmap -6 -sUV -p $PORTS -P0 $CMIP6 -T4 --version-intensity=2 --min-rate=1000  | tee -a $FILENAME
    echo -e "\n---------------------------------------------------------------------------------\n" | tee -a $FILENAME
    echo -e "De portscans zijn afgerond, de resultaten staan in de map $FILENAME"
}

function portscan_IPv4_LAN{
    CURRENTDIR=$pwd
    CMIP4=$1
    NOW=$(date +"%d_%m_%Y_%R")
    DIRNAME=$NOW-Portscan
    FILENAME=$CURRENTDIR/$DIRNAME/$NOW-portscan.txt
    if [ -z "$2" ]
    then
        PORTS=1-65535
    else
        PORTS=$2
    fi
    mkdir $DIRNAME
    echo -e "De ipv4 TCP WAN Portscan start nu voor het IPv4 adres $1 op de poorten $PORTS\n" | tee -a $FILENAME
    nmap -sS -p $PORTS -P0 $CMIP4 --max-retries=2 -T4 | tee -a $FILENAME
    echo -e "\n---------------------------------------------------------------------------------\n" | tee -a $FILENAME
    echo -e "De ipv4 UDP WAN Portscan start nu voor het IPv4 adres $1 op de poorten $PORTS\n" | tee -a $FILENAME
    nmap -sUV -p $PORTS -P0 $CMIP4 -T4 --version-intensity=2 --min-rate=1000 | tee -a $FILENAME
    echo -e "\n---------------------------------------------------------------------------------\n" | tee -a $FILENAME
    echo -e "De portscans zijn afgerond, de resultaten staan in de map $FILENAME"
}

function portscan_IPv6_LAN{
    CURRENTDIR=$pwd
    CMIP6=$1
    NOW=$(date +"%d_%m_%Y_%R")
    DIRNAME=$NOW-Portscan
    FILENAME=$CURRENTDIR/$DIRNAME/$NOW-portscan.txt
    if [ -z "$2" ]
    then
        PORTS=1-65535
    else
        PORTS=$2
    fi
    mkdir $DIRNAME
    echo -e "De ipv6 TCP WAN Portscan start nu voor het IPv6 adres $2 op de poorten $PORTS\n" | tee -a $FILENAME
    nmap -6 -sS -p $PORTS -P0 $CMIP6 -T4 --max-retries=2 -T4 | tee -a $FILENAME
    echo -e "\n---------------------------------------------------------------------------------\n" | tee -a $FILENAME
    echo -e "De ipv6 UDP WAN Portscan start nu voor het IPv6 adres $2 op de poorten $PORTS\n" | tee -a $FILENAME
    nmap -6 -sUV -p $PORTS -P0 $CMIP6 -T4 --version-intensity=2 --min-rate=1000  | tee -a $FILENAME
    echo -e "\n---------------------------------------------------------------------------------\n" | tee -a $FILENAME
    echo -e "De portscans zijn afgerond, de resultaten staan in de map $FILENAME"
}

function portscan_IPv4-IPv6_LAN{
    CURRENTDIR=$pwd
    CMIP6=$2
    NOW=$(date +"%d_%m_%Y_%R")
    DIRNAME=$NOW-Portscan
    FILENAME=$CURRENTDIR/$DIRNAME/$NOW-portscan.txt
    if [ -z "$3" ]
    then
        PORTS=1-65535
    else
        PORTS=$3
    fi
    mkdir $DIRNAME
    echo -e "De ipv4 TCP WAN Portscan start nu voor het IPv4 adres $1 op de poorten $PORTS\n" | tee -a $FILENAME
    nmap -sS -p $PORTS -P0 $CMIP4 --max-retries=2 -T4 | tee -a $FILENAME
    echo -e "\n---------------------------------------------------------------------------------\n" | tee -a $FILENAME
    echo -e "De ipv4 UDP WAN Portscan start nu voor het IPv4 adres $1 op de poorten $PORTS\n" | tee -a $FILENAME
    nmap -sUV -p $PORTS -P0 $CMIP4 -T4 --version-intensity=2 --min-rate=1000 | tee -a $FILENAME
    echo -e "\n---------------------------------------------------------------------------------\n" | tee -a $FILENAME
    echo -e "De ipv6 TCP WAN Portscan start nu voor het IPv6 adres $2 op de poorten $PORTS\n" | tee -a $FILENAME
    nmap -6 -sS -p $PORTS -P0 $CMIP6 -T4 --max-retries=2 -T4 | tee -a $FILENAME
    echo -e "\n---------------------------------------------------------------------------------\n" | tee -a $FILENAME
    echo -e "De ipv6 UDP WAN Portscan start nu voor het IPv6 adres $2 op de poorten $PORTS\n" | tee -a $FILENAME
    nmap -6 -sUV -p $PORTS -P0 $CMIP6 -T4 --version-intensity=2 --min-rate=1000  | tee -a $FILENAME
    echo -e "\n---------------------------------------------------------------------------------\n" | tee -a $FILENAME
    echo -e "De portscans zijn afgerond, de resultaten staan in de map $FILENAME"
}

function portscan_IPv4-IPv6_WAN_LAN{
    CURRENTDIR=$pwd
    LANCMIP4=$1
    LANCMIP6=$2
    WANCMIP4=$3
    WANCMIP6=$4
    NOW=$(date +"%d_%m_%Y_%R")
    DIRNAME=$NOW-Portscan
    FILENAME=$CURRENTDIR/$DIRNAME/$NOW-portscan.txt
    if [ -z "$5" ]
    then
        PORTS=1-65535
    else
        PORTS=$5
    fi
    mkdir $DIRNAME
    echo -e "De ipv4 TCP LAN Portscan start nu voor het IPv4 adres $1 op de poorten $PORTS\n" | tee -a $FILENAME
    nmap -sS -p $PORTS $1 -T4 --min-rate=1000 | tee -a $FILENAME
    echo -e "\n---------------------------------------------------------------------------------\n" | tee -a $FILENAME
    echo -e "De ipv4 UDP LAN Portscan start nu voor het IPv4 adres $1 op de poorten $PORTS\n" | tee -a $FILENAME
    nmap -sUV -p $PORTS -P0 $1 -T4 --version-intensity=2 --min-rate=1000 | tee -a $FILENAME
    echo -e "\n---------------------------------------------------------------------------------\n" | tee -a $FILENAME
    echo -e "De ipv6 TCP LAN Portscan start nu voor het IPv6 adres $2 op de poorten $PORTS\n" | tee -a $FILENAME
    nmap -6 -sS -p $PORTS -P0 $2 -T4 --max-retries=2 -T4 | tee -a $FILENAME
    echo -e "\n---------------------------------------------------------------------------------\n" | tee -a $FILENAME
    echo -e "De ipv6 UDP LAN Portscan start nu voor het IPv6 adres $2 op de poorten $PORTS\n" | tee -a $FILENAME
    nmap -6 -sUV -p $PORTS -P0 $2 -T4 --version-intensity=2 --min-rate=1000  | tee -a $FILENAME
    echo -e "\n---------------------------------------------------------------------------------\n" | tee -a $FILENAME
    echo -e "De portscans zijn afgerond, de resultaten staan in de map $FILENAME"
    echo -e "De ipv4 TCP WAN Portscan start nu voor het IPv4 adres $3 op de poorten $PORTS\n" | tee -a $FILENAME
    nmap -sS -p $PORTS -P0 $3 --max-retries=2 -T4 | tee -a $FILENAME
    echo -e "\n---------------------------------------------------------------------------------\n" | tee -a $FILENAME
    echo -e "De ipv4 UDP WAN Portscan start nu voor het IPv4 adres $3 op de poorten $PORTS\n" | tee -a $FILENAME
    nmap -sUV -p $PORTS -P0 $3 -T4 --version-intensity=2 --min-rate=1000 | tee -a $FILENAME
    echo -e "\n---------------------------------------------------------------------------------\n" | tee -a $FILENAME
    echo -e "De ipv6 TCP WAN Portscan start nu voor het IPv6 adres $4 op de poorten $PORTS\n" | tee -a $FILENAME
    nmap -6 -sS -p $PORTS -P0 $4 -T4 --max-retries=2 -T4 | tee -a $FILENAME
    echo -e "\n---------------------------------------------------------------------------------\n" | tee -a $FILENAME
    echo -e "De ipv6 UDP WAN Portscan start nu voor het IPv6 adres $4 op de poorten $PORTS\n" | tee -a $FILENAME
    nmap -6 -sUV -p $PORTS -P0 $4 -T4 --version-intensity=2 --min-rate=1000  | tee -a $FILENAME
    echo -e "\n---------------------------------------------------------------------------------\n" | tee -a $FILENAME
    echo -e "De portscans zijn afgerond, de resultaten staan in de map $FILENAME"
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
                echo "Invalid IPv4 address"
                break;
            fi
            echo "Welke poorten wil je scannen? (Enter = 1-65535)"
            read Ports
            portscan_IPv4_WAN $IPv4 $Ports
            break
            ;;
        "Portscan WAN IPv6")
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
            portscan_IPv6_WAN $IPv6 $Ports
            break
            ;;
        "Portscan WAN IPv4 and IPv6")
            echo "Wat is het IPv4 adres?"
            read IPv4
            valid_ip4 $IPv4
            if valid_ip4 $IPv4; then stat='good4'; else stat='bad4'; fi
            if [ $stat == 'bad4' ]
            then
                echo "Invalid IPv4 address"
                break;
            fi
            echo "Wat is het IPv6 adres?"
            read IPv6
            valid_ip6 $IPv6
            if valid_ip6 $IPv6; then stat='good6'; else stat='bad6'; fi
            if [ $stat == 'bad6' ]
            then
                echo 'Invalid IPv6 address'
                break;
            fi
            echo "Welke poorten wil je scannen? (Enter = 1-65535)"
            read Ports
            portscan_IPv4-IPv6_WAN $IPv4 $IPv6 $Ports
            break
            ;;
        "Portscan LAN IPv4")
            echo "Wat is het IPv4 adres?"
            read IPv4
            valid_ip4 $IPv4
            if valid_ip4 $IPv4; then stat='good4'; else stat='bad4'; fi
            if [ $stat == 'bad4' ]
            then
                echo "Invalid IPv4 address"
                break;
            fi
            echo "Welke poorten wil je scannen? (Enter = 1-65535)"
            read Ports
            portscan_IPv4_LAN $IPv4 $Ports
            break
            ;;
        "Portscan LAN IPv6")
            echo "Wat is het IPv6 adres?"
            read IPv6
            valid_ip6 $IPv6
            if valid_ip6 $IPv6; then stat='good6'; else stat='bad6'; fi
            if [ $stat == 'bad6' ]
            then
                echo 'Invalid IPv6 address'
                break;
            fi
            echo "Welke poorten wil je scannen? (Enter = 1-65535)"
            read Ports
            portscan_IPv6_LAN $IPv6 $Ports
            break
            ;;
        "Portscan LAN IPv4 and IPv6")
            echo "Wat is het IPv4 adres?"
            read IPv4
            valid_ip4 $IPv4
            if valid_ip4 $IPv4; then stat='good4'; else stat='bad4'; fi
            if [ $stat == 'bad4' ]
            then
                echo "Invalid IPv4 address"
                break;
            fi
            echo "Wat is het IPv6 adres?"
            read IPv6
            valid_ip6 $IPv6
            if valid_ip6 $IPv6; then stat='good6'; else stat='bad6'; fi
            if [ $stat == 'bad6' ]
            then
                echo 'Invalid IPv6 address'
                break;
            fi
            echo "Welke poorten wil je scannen? (Enter = 1-65535)"
            read Ports
            portscan_IPv4-IPv6_LAN $IPv4 $IPv6 $Ports
            break
            ;;
        "Portscan WAN+LAN IPv4 + IPv6")
            echo "Wat is het IPv4 LAN adres?"
            read IPv4LAN
            valid_ip4 $IPv4LAN
            if valid_ip4 $IPv4LAN; then stat='good4'; else stat='bad4'; fi
            if [ $stat == 'bad4' ]
            then
                echo "Invalid IPv4 address"
                break;
            fi
            echo "Wat is het IPv6 LAN adres?"
            read IPv6LAN
            valid_ip6 $IPv6LAN
            if valid_ip6 $IPv6LAN; then stat='good6'; else stat='bad6'; fi
            if [ $stat == 'bad6' ]
            then
                echo 'Invalid IPv6 address'
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
                echo 'Invalid IPv6 address'
                break;
            fi
            echo "Welke poorten wil je scannen? (Enter = 1-65535)"
            read Ports
            portscan_IPv4-IPv6_WAN_LAN $IPv4LAN $IPv6LAN $IPv4WAN $IPv6WAN $Ports
            break
            ;;
        "Rennen en wegwezen")
            break
            ;;
        *) echo "ongeldige optie $REPLY";;
    esac
done