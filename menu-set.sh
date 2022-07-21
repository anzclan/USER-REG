#!/bin/bash
clear
MYIP=$(curl -s https://icanhazip.com)

echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[40;1;37m|            • UPDATE PORT PANEL •               |\E[0m"
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
  port-
  ;;
02 | 2)
  clear
  port-
  ;;
03 | 3)
  clear
  port-
  ;;
04 | 4)
  clear
  port-
  ;;
05 | 5)
  clear
  port-
  ;;
00 | 0)
  clear
  menu
  ;;
*)
  clear
  menu-port
  ;;
esac
