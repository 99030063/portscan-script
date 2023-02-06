#! /bin/bash

# ./portscan5.sh [IPv4] [Poorten]
# ./portscan5.sh 83.128.3.148 23-24

CURRENTDIR=$(pwd)
CMIP4=$1
NOW=$(date +"%d_%m_%Y_%R")
DIRNAME=$NOW-Portscan
FILENAME=$CURRENTDIR/$NOW-portscan.txt

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
