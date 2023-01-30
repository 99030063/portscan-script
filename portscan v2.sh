#!/bin/bash
echo -e "Which scan do you want to run"
CHOICE=0
echo "1. TCP IPv4"
echo "2. TCP IPv6"
echo "3. UDP IPv4"
echo "4. UDP IPv6"
echo "5. All of the above"

while [ $CHOICE -eq 0 ]; do
    read CHOICE
    echo -n "You chose "
    case $CHOICE in
        1)
            echo "TCP IPv4"
            CHOICE=1
            ;;
        2)
            echo "TCP IPv6"
            CHOICE=2
            ;;
        3)
            echo "UDP IPv4"
            CHOICE=3
            ;;
        4)
            echo "UDP IPv6"
            CHOICE=4
            ;;
        5)
            echo "all of the above"
            CHOICE=5
            ;;
    #add more options here (for future reference)
        *)
            echo "an unavailable option, please try again"
            CHOICE=0
            ;;
    esac
done

echo "DEBUG 'Choice made' "
VAR=1
while [ $VAR -eq 1] ; do
    read -p "What IP address do you want to use for the TCP IPv4 Portscan?" TCP4
    while true ; do
    read -p "You typed [$TCP4], is this correct? (y/n) " yn
        case $yn in
            [yY] ) echo "ok, we will proceed";
                VAR=0
                break
                ;;
            [nN] ) echo "Allright, let's try again";
                VAR=1
                break
                ;;
            * ) echo "invalid response";
                continue;;
        esac
    done
done
echo "DEBUG  'IP Confirmed' "





