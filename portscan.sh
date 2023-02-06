menu.sh
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


portscan_IPv4.sh
#! /bin/bash

# ./portscan5.sh [IPv4] [Poorten]
# ./portscan5.sh 83.128.3.148 23-24

CMIP4=$1
NOW=$(date +"%d_%m_%Y_%R")
DIRNAME=$NOW-Portscan
FILENAME=/var/roald/$DIRNAME/$NOW-portscan.txt

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

echo -e "De portscans zijn afgerond, de resultaten staan in de map /var/roald/$DIRNAME"


portscan_IPv6.sh
#! /bin/bash

# ./portscan5.sh [IPv6] [Poorten]
# ./portscan5.sh fe80::daa7:56ff:fef4:f94a 23-24

CMIP6=$1
NOW=$(date +"%d_%m_%Y_%R")
DIRNAME=$NOW-Portscan
FILENAME=/var/roald/$DIRNAME/$NOW-portscan.txt

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
echo -e "De portscans zijn afgerond, de resultaten staan in de map /var/roald/$DIRNAME"




portscan_IPv4-IPv6.sh
#! /bin/bash

# ./portscan5.sh [IPv4] [IPv6] [Poorten]
# ./portscan5.sh 83.128.3.148 fe80::daa7:56ff:fef4:f94a 23-24

CMIP4=$1
CMIP6=$2
NOW=$(date +"%d_%m_%Y_%R")
DIRNAME=$NOW-Portscan
FILENAME=/var/roald/$DIRNAME/$NOW-portscan.txt

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
echo -e "De portscans zijn afgerond, de resultaten staan in de map /var/roald/$DIRNAME"






