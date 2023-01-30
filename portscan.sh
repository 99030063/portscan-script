#!/bin/bash

echo -e "What 4 hosts do you want to use (use a space to seperate the different IP addresses)"
read -a hosts

echo -e "Which host will be used for the IPv4 LAN tcp scan?"
CHOICE=0
echo "1. ${hosts[0]}"
echo "2. ${hosts[1]}"
echo "3. ${hosts[2]}"
echo "4. ${hosts[3]}"

while [ $CHOICE -eq 0 ]; do
    read CHOICE
    echo -n "You chose "
    case $CHOICE in
        1)
            echo "${hosts[0]}"
            CHOICE=1
            ;;
        2)
            echo "${hosts[1]}"
            CHOICE=2
            ;;
        3)
            echo "${hosts[2]}"
            CHOICE=3
            ;;
        4)
            echo "${hosts[3]}"
            CHOICE=4
            ;;
    #add more options here (for future reference)
        *)
            echo "an unavailable option, please try again"
            CHOICE=0
            ;;
    esac
done

echo "while loop gesloten"

