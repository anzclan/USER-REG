#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
#########################
# COLOR
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'

MYIP=$(curl -s https://icanhazip.com)

clear
tcp_status() {
  if [[ $(grep -c "^#PH56" /etc/sysctl.conf) -eq 1 ]]; then
    echo -e " TCP Tweak Current status : ${green}Installed${NC}"
  else
    echo -e " TCP Tweak Current status : ${red}Not Installed${NC}"
  fi
}

# status tweak
tcp_2_status() {
  if [[ $(grep -c "^##VpsPack" /etc/sysctl.conf) -eq 1 ]]; then
    echo -e " TCP Tweak 2 Current status : ${green}Installed${NC}"
  else
    echo -e " TCP Tweak 2 Current status : ${red}Not Installed${NC}"
  fi
}

# status bbr
bbr_status() {
  local param=$(sysctl net.ipv4.tcp_congestion_control | awk '{print $3}')
  if [[ x"${param}" == x"bbr" ]]; then
    echo -e " BBR Current status : ${green}Installed${NC}"
  else
    echo -e " BBR Current status : ${red}Not Installed${NC}"
  fi
}

delete_bbr() {
  clear
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[40;1;37m|               • TWEEAK PANEL •                 |\E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
  echo
  read -p "Do you want to remove BBR settings? [y/n]: " -e answer0
  if [[ "$answer0" = 'y' ]]; then
    grep -v "^#BBR
net.core.default_qdisc = fq
net.ipv4.tcp_congestion_control = bbr" /etc/sysctl.conf >/tmp/syscl && mv /tmp/syscl /etc/sysctl.conf
    sysctl -p /etc/sysctl.conf >/dev/null
    echo "cubic" >/proc/sys/net/ipv4/tcp_congestion_control
    echo ""
    echo "BBR settings were successfully removed."
    echo ""
    read -n 1 -s -r -p "Press any key to back"
    tweak
  else
    echo ""
    tweak
  fi
}

sysctl_config() {
  sed -i '/net.core.default_qdisc/d' /etc/sysctl.conf
  sed -i '/net.ipv4.tcp_congestion_control/d' /etc/sysctl.conf
  echo "" >>/etc/sysctl.conf
  echo "#BBR" >>/etc/sysctl.conf
  echo "net.core.default_qdisc = fq" >>/etc/sysctl.conf
  echo "net.ipv4.tcp_congestion_control = bbr" >>/etc/sysctl.conf
  sysctl -p >/dev/null 2>&1
}

check_bbr_status() {
  local param=$(sysctl net.ipv4.tcp_congestion_control | awk '{print $3}')
  if [[ x"${param}" == x"bbr" ]]; then
    return 0
  else
    return 1
  fi
}

version_ge() {
  test "$(echo "$@" | tr " " "\n" | sort -rV | head -n 1)" == "$1"
}

check_kernel_version() {
  local kernel_version=$(uname -r | cut -d- -f1)
  if version_ge ${kernel_version} 4.9; then
    return 0
  else
    return 1
  fi
}

install_bbr2() {
  check_bbr_status
  if [ $? -eq 0 ]; then
    echo
    echo -e "[ Information ]  TCP BBR has already been installed. nothing to do..."
    echo
    read -n 1 -s -r -p "Press any key to back"
    tweak
  fi
  check_kernel_version
  if [ $? -eq 0 ]; then
    echo
    echo -e "[ Information ]  Your kernel version is greater than 4.9, directly setting TCP BBR..."
    sysctl_config
    echo -e "[ Information ]  Setting TCP BBR completed..."
    echo
    read -n 1 -s -r -p "Press any key to back"
    tweak
  fi

  if [[ x"${release}" == x"centos" ]]; then
    echo ""
    echo -e "[ Invalid ] Centos not support"
    echo ""
    read -n 1 -s -r -p "Press any key to back"
    tweak
  fi
}

install_bbr() {
  clear
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[40;1;37m|               • TWEEAK PANEL •                 |\E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
  echo
  echo "Ini adalah skrip percubaan. Gunakan atas risiko anda sendiri!"
  echo "Skrip ini akan menukar beberapa network settings"
  echo "untuk mengurangkan latency dan meningkatkan kelajuan."
  echo ""
  read -p "Proceed with installation? [y/n]: " -e answer
  if [[ "$answer" = 'y' ]]; then
    install_bbr2
  else
    echo
    read -n 1 -s -r -p "Press any key to back"
    tweak
  fi
}

delete_Tweaker() {
  clear
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[40;1;37m|               • TWEEAK PANEL •                 |\E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
  echo
  read -p "Do you want to remove TCP Tweaker settings? [y/n]: " -e answer0
  if [[ "$answer0" = 'y' ]]; then
    grep -v "^#PH56
net.ipv4.tcp_window_scaling = 1
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_rmem = 4096 87380 16777216
net.ipv4.tcp_wmem = 4096 16384 16777216
net.ipv4.tcp_low_latency = 1
net.ipv4.tcp_slow_start_after_idle = 0" /etc/sysctl.conf >/tmp/syscl && mv /tmp/syscl /etc/sysctl.conf
    sysctl -p /etc/sysctl.conf >/dev/null
    echo ""
    echo "TCP Tweaker network settings were successfully removed."
    echo ""
    read -n 1 -s -r -p "Press any key to back"
    tweak
  else
    echo ""
    tweak
  fi
}

install_Tweaker() {
  clear
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[40;1;37m|               • TWEEAK PANEL •                 |\E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
  echo
  echo "Ini adalah skrip percubaan. Gunakan atas risiko anda sendiri!"
  echo "Skrip ini akan menukar beberapa network settings"
  echo "untuk mengurangkan latency dan meningkatkan kelajuan."
  echo ""
  read -p "Proceed with installation? [y/n]: " -e answer
  if [[ "$answer" = 'y' ]]; then
    echo ""
    echo "Modifying the following settings:"
    echo " " >>/etc/sysctl.conf
    echo "#PH56" >>/etc/sysctl.conf
    echo "net.ipv4.tcp_window_scaling = 1
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_rmem = 4096 87380 16777216
net.ipv4.tcp_wmem = 4096 16384 16777216
net.ipv4.tcp_low_latency = 1
net.ipv4.tcp_slow_start_after_idle = 0" >>/etc/sysctl.conf
    echo ""
    sysctl -p /etc/sysctl.conf >/dev/null
    echo "TCP Tweaker network settings have been added successfully."
    echo ""
    read -n 1 -s -r -p "Press any key to back"
    tweak
  else
    echo ""
    echo "Installation was canceled by the user!"
    echo ""
  fi
}

delete_Tweaker_2() {
  clear
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[40;1;37m|               • TWEEAK PANEL •                 |\E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
  echo
  read -p "Do you want to remove TCP Tweaker settings? [y/n]: " -e answer0
  if [[ "$answer0" = 'y' ]]; then
    grep -v "^##VpsPack
net.ipv4.tcp_fin_timeout = 2
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_keepalive_time = 600
net.ipv4.ip_local_port_range = 2000 65000
net.ipv4.tcp_max_syn_backlog = 16384
net.ipv4.tcp_max_tw_buckets = 36000
net.ipv4.route.gc_timeout = 100
net.ipv4.tcp_syn_retries = 1
net.ipv4.tcp_synack_retries = 1
net.ipv4.tcp_max_orphans = 16384
net.core.somaxconn = 16384
net.core.netdev_max_backlog = 16384" /etc/sysctl.conf >/tmp/syscl && mv /tmp/syscl /etc/sysctl.conf
    sysctl -p /etc/sysctl.conf >/dev/null
    echo ""
    echo "TCP Tweaker network settings were successfully removed."
    echo ""
    read -n 1 -s -r -p "Press any key to back"
    tweak
  else
    echo ""
    tweak
  fi
}

install_Tweaker_2() {
  clear
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[40;1;37m|               • TWEEAK PANEL •                 |\E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
  echo
  echo "Ini adalah skrip percubaan. Gunakan atas risiko anda sendiri!"
  echo "Skrip ini akan menukar beberapa network settings"
  echo "untuk mengurangkan latency dan meningkatkan kelajuan."
  echo ""
  read -p "Proceed with installation? [y/n]: " -e answer
  if [[ "$answer" = 'y' ]]; then
    echo ""
    echo "Modifying the following settings:"
    echo " " >>/etc/sysctl.conf
    echo "##VpsPack" >>/etc/sysctl.conf
    echo "net.ipv4.tcp_fin_timeout = 2
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_keepalive_time = 600
net.ipv4.ip_local_port_range = 2000 65000
net.ipv4.tcp_max_syn_backlog = 16384
net.ipv4.tcp_max_tw_buckets = 36000
net.ipv4.route.gc_timeout = 100
net.ipv4.tcp_syn_retries = 1
net.ipv4.tcp_synack_retries = 1
net.ipv4.tcp_max_orphans = 16384
net.core.somaxconn = 16384
net.core.netdev_max_backlog = 16384" >>/etc/sysctl.conf
    echo ""
    sysctl -p /etc/sysctl.conf >/dev/null
    echo "TCP Tweaker network settings have been added successfully."
    echo ""
    read -n 1 -s -r -p "Press any key to back"
    tweak
  else
    echo ""
    echo "Installation was canceled by the user!"
    echo ""
  fi
}

# menu tweaker
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[40;1;37m|               • TWEEAK PANEL •                 |\E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
tcp_status
tcp_2_status
bbr_status
echo
echo -e " [\e[36m01\e[0m] • Install BBR "
echo -e " [\e[36m02\e[0m] • Install TCP Tweaker "
echo -e " [\e[36m03\e[0m] • Install TCP Tweaker 2"
echo -e ""
echo -e " [\e[36m04\e[0m] • Delete BBR "
echo -e " [\e[36m05\e[0m] • Delete TCP Tweaker"
echo -e " [\e[36m06\e[0m] • Delete TCP Tweaker 2"
echo -e ""
echo -e " [00] • Back to Main Menu \033[1;32m<\033[1;33m<\033[1;31m<\033[1;31m"
echo -e ""
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
read -p " Select menu :  " opt
echo -e "$DF"
case $opt in
01 | 1) clear ; install_bbr 2>&1 ;;
02 | 2) clear ; install_Tweaker 2>&1 ;;
03 | 3) clear ; install_Tweaker_2 2>&1 ;;
04 | 4) clear ; delete_bbr ;;
05 | 5) clear ; delete_Tweaker ;;
06 | 6) clear ; delete_Tweaker_2 ;;
00 | 0) clear ; menu ;;
*)
  clear
  tweak
  ;;
esac
