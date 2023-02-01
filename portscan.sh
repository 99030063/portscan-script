#!/bin/bash
echo -e "Which scan do you want to run"
CHOICE=0
echo "1. TCP IPv4"
echo "2. TCP IPv6"
echo "3. UDP IPv4"
echo "4. UDP IPv6"
echo "5. All of the above"
SCAN=0
while [ $CHOICE -eq 0 ]; do
    read CHOICE
    echo -n "You chose "
    case $CHOICE in
        1)
            SCAN="TCP IPv4"
            echo $SCAN
            CHOICE=1
            ;;
        2)
            SCAN="TCP IPv6"
            echo $SCAN
            CHOICE=2
            ;;
        3)
            SCAN="UDP IPv4"
            echo $SCAN
            CHOICE=3
            ;;
        4)
            SCAN="UDP IPv6"
            echo $SCAN
            CHOICE=4
            ;;
        5)
            echo "all of the above"
            scanARRAY=('TCP IPv4' 'TCP IPv6' 'UDP IPv4' 'UDP IPv6')
            CHOICE=5
            ;;
    #add more options here (for future reference)
        *)
            echo "an unavailable option, please try again"
            CHOICE=0
            ;;
    esac
done

echo "DEBUG 'Choice made' $CHOICE"
ipARRAY=()
ipQuestion(){
    VAR=1
    while [ $VAR -eq 1 ] ; do
        echo "What IP address do you want to use for the $* Portscan?"
        read IP
        while true ; do
        read -p "You typed [$IP], is this correct? (y/n) " yn
            case $yn in
                [yY] ) echo "Confirmed";
                    VAR=0
                    ipARRAY=(${ipARRAY[@]} "$IP")
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
}

if [ $CHOICE == 5 ]; then
    for i in "${scanARRAY[@]}"; do
        # echo "test: $i"
        ipQuestion $i
        # echo "Alle testen worden uitgevoerd met deze ip's: "
    done
    echo "These tests will be run with these IP Addresses"
    for i in {0..3}
    do
        echo "Test: "${scanARRAY[i]}" - IP: "${ipARRAY[i]}"" 
    done
    
    # for value in "${ipARRAY[@]}"; do
    #         echo "Test: "$scanARRAY[$i]" - IP: $value" 
    #     done
elif [ $CHOICE -ge 1 ] && [ $CHOICE -le 4 ]; then
    ipQuestion "$SCAN"
    echo "This test will be run: "
    echo "Test: "$SCAN" - IP: "${ipARRAY[@]}" "
fi

# if [ $CHOICE -eq 5 ] then
#     for i in "${scanARRAY[@]}"
#     do
#         #ipQuestion($i)
#         echo $i
#     done
# else
#     echo "DEBUG 'test else'"
#     ipQuestion($SCAN)
# fi

# echo "DEBUG  'IP Confirmed' "

# if [ $CHOICE == 5 ]; then
#     echo "Alle testen worden uitgevoerd"
#             NOW='TCP_IPv4_$(date +"%Y%m%d")'
#             nmap -sS -p 21 $ipARRAY["$CHOICE-5"] -T4 --min-rate=1000 >> $NOW.txt
#             ;;
#             NOW='TCP_IPv6_$(date +"%Y%m%d")'
#             nmap -sS -6 -p 21 $ipARRAY["$CHOICE-4"] -T4 --min-rate=1000 >> $NOW.txt
#             ;;
#             NOW='UDP_IPv4_$(date +"%Y%m%d")'
#             nmap -sUV -p 21 -P0 $ipARRAY["$CHOICE-3"] -T4 --version-intensity=2 --min-rate=1000 >> $NOW.txt
#             ;;
#             NOW='UDP_IPv6_$(date +"%Y%m%d")'
#             nmap -sUV -6 -p 21 -P0 $ipARRAY["$CHOICE-2"] -T4 --version-intensity=2 --min-rate=1000 >> $NOW.txt

# elif [[ $CHOICE -ge 1 ]] && [[ $CHOICE -le 4 ]]; then
#     case $CHOICE in
#         1)
#             NOW='TCP_IPv4_$(date +"%Y%m%d")'
#             nmap -sS -p 21-22 $ipARRAY[0] -T4 --min-rate=1000 >> $NOW.txt
#             ;;
#         2)
#             NOW='TCP_IPv6_$(date +"%Y%m%d")'
#             nmap -sS -6 -p 1-65535 $ipARRAY[0] -T4 --min-rate=1000 >> $NOW.txt
#             ;;
#         3)
#             NOW='UDP_IPv4_$(date +"%Y%m%d")'
#             nmap -sUV -p 1-65535 -P0 $ipARRAY[0] -T4 --version-intensity=2 --min-rate=1000 >> $NOW.txt
#             ;;
#         4)
#             NOW='UDP_IPv6_$(date +"%Y%m%d")'
#             nmap -sUV -6 -p 1-65535 -P0 $ipARRAY[0] -T4 --version-intensity=2 --min-rate=1000 >> $NOW.txt            
#             ;;
#     esac
# fi


