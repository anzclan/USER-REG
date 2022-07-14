#!/bin/bash
clear
MYIP=$(curl -s https://icanhazip.com)

echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[40;1;37m|               • BACKUP PANEL •                 |\E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "
 [\033[1;36m01\033[0m] • MENU
 [\033[1;36m02\033[0m] • MENU
 [\033[1;36m03\033[0m] • MENU
 [\033[1;36m04\033[0m] • MENU
 [\033[1;36m05\033[0m] • MENU

 [00] • Back to Main Menu \033[1;32m<\033[1;33m<\033[1;31m<\033[1;31m
 "

echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
read -p " Select menu : " opt
echo -e ""
case $opt in
01 | 1)
  clear
  MENU
  ;;
02 | 2)
  clear
  MENU
  ;;
03 | 3)
  clear
  MENU
  ;;
04 | 4)
  clear
  MENU
  ;;
05 | 5)
  clear
  MENU
  ;;
00 | 0)
  clear
  menu
  ;;
*)
  clear
  menu-bkp
  ;;
esac
