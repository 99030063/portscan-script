#! /bin/bash

# ./portscan5.sh [IPv4] [IPv6] [Poorten]
# ./portscan5.sh 83.128.3.148 fe80::daa7:56ff:fef4:f94a 23-24

CMIP4=$1
CMIP6=$2
NOW=$(date +"%d_%m_%Y_%R")
DIRNAME= $(~)/$NOW-Portscan
FILENAME=$DIRNAME/$NOW-portscan.txt

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
