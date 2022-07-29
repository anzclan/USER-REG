#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`

###########- COLOR CODE -##############
NC="\033[0m"                          #
RED="\033[0;31m"                      #
COLOR1="\033[0;32m" #DEFAULT GREEN    #
COLBG1="\E[40;1;42m" #DEFAULT GREEN   #
###########- END COLOR CODE -##########

BURIQ () {
    curl -sS https://raw.githubusercontent.com/anzclan/USER-REG/main/ip > /root/tmp
    data=( `cat /root/tmp | grep -E "^### " | awk '{print $2}'` )
    for user in "${data[@]}"
    do
    exp=( `grep -E "^### $user" "/root/tmp" | awk '{print $3}'` )
    d1=(`date -d "$exp" +%s`)
    d2=(`date -d "$biji" +%s`)
    exp2=$(( (d1 - d2) / 86400 ))
    if [[ "$exp2" -le "0" ]]; then
    echo $user > /etc/.$user.ini
    else
    rm -f /etc/.$user.ini > /dev/null 2>&1
    fi
    done
    rm -f /root/tmp
}

MYIP=$(curl -sS ipv4.icanhazip.com)
Name=$(curl -sS https://raw.githubusercontent.com/anzclan/USER-REG/main/ip | grep $MYIP | awk '{print $2}')
echo $Name > /usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)

Bloman () {
if [ -f "/etc/.$Name.ini" ]; then
CekTwo=$(cat /etc/.$Name.ini)
    if [ "$CekOne" = "$CekTwo" ]; then
        res="Expired"
    fi
else
res="Permission Accepted..."
fi
}

PERMISSION () {
    MYIP=$(curl -sS ipv4.icanhazip.com)
    IZIN=$(curl -sS https://raw.githubusercontent.com/anzclan/USER-REG/main/ip | awk '{print $4}' | grep $MYIP)
    if [ "$MYIP" = "$IZIN" ]; then
    Bloman
    else
    res="Permission Denied!"
    fi
    BURIQ
}

PERMISSION
if [ "$res" = "Expired" ]; then
Exp="${RED}Expired${NC}"
rm -f /home/needupdate > /dev/null 2>&1
else
Exp=$(curl -sS https://raw.githubusercontent.com/anzclan/USER-REG/main/ip | grep $MYIP | awk '{print $3}')
fi

clear
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$NC"
echo -e "$COLBG1               • XRAY : XTLS MENU •               $NC"
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$NC"
echo -e "
 ${COLOR1}[01]${NC} • Create Vless TCP XTLS Account
 ${COLOR1}[02]${NC} • Deleting Vless TCP XTLS Account
 ${COLOR1}[03]${NC} • Extending Vless TCP XTLS Account
 ${COLOR1}[04]${NC} • Chek User Login XTLS

 ${COLOR1}[01]${NC} • Back to Main Menu \033[1;32m<\033[1;33m<\033[1;31m<\033[1;31m
 "
echo -e "$COLOR1━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$NC"
echo -e ""
read -p " Select menu : " opt
echo -e ""
case $opt in
01 | 1)
  clear
  menu1
  ;;
02 | 2)
  clear
  menu2
  ;;
03 | 3)
  clear
  menu3
  ;;
04 | 4)
  clear
  menu4
  ;;
00 | 0)
  clear
  menu
  ;;
*)
  clear
  menu-xtls
  ;;
esac
