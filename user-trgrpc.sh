#!/bin/bash
clear
MYIP=$(curl -s https://icanhazip.com)
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/xray-mini/trojangrpc.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
  echo ""
  echo "Name : User XRAY TRgRPC Account"
  echo ""
  echo "You have no existing clients!"
  exit 1
fi

clear
echo ""
echo "Name : User XRAY TRgRPC Account"
echo ""
echo " Select the existing client you want to Show Config"
echo " Press CTRL+C to return"
echo ""
echo " ==============================="
echo "     No  User   Expired"
grep -E "^### " "/etc/xray-mini/trojangrpc.json" | cut -d ' ' -f 2-3 | nl -s ') '
until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
  if [[ ${CLIENT_NUMBER} == '1' ]]; then
    read -rp "Select one client [1]: " CLIENT_NUMBER
  else
    read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
  fi
done
user=$(grep -E "^### " "/etc/xray-mini/trojangrpc.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/etc/xray-mini/trojangrpc.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
hariini=$(date -d "0 days" +"%Y-%m-%d")
trg="$(cat /etc/xray-mini/trojangrpc.json | grep port | sed 's/"//g' | sed 's/port//g' | sed 's/://g' | sed 's/,//g' | sed 's/ //g')"
domain=$(cat /root/domain)
uuid=$(cat /etc/xray-mini/trojangrpc.json | grep -w "${user}" | grep "password" | cut -f 2 -d ':' | cut -f 2 -d '"')
username=${user}
read -p "ISI WILD CARD DOMAIN DIAKHIRI DOT (.)/ENTER JIKA TIADA  : " WILD
read -p "BUG TELCO  : " sni

# // Link Configration

trojanlink="trojan://${uuid}@${WILD}${domain}:${trg}/?security=tls&type=grpc&serviceName=GunService&sni=$sni#$username"

systemctl restart trojan-grpc

# // Success
sleep 1

# // Clear
clear && clear && clear
clear

echo -e ""
echo -e "==============================="
echo -e "      YOUR XRAY Trojan gRPC    "
echo -e "==============================="

echo -e "==============================="
echo -e "Remarks   : ${username}"
echo -e "IP        : ${MYIP}"
echo -e "Domain    : ${domain}"
echo -e "Website   : https://${domain}"
echo -e "Port      : ${trg}"
echo -e "==============================="
echo -e "     Link Xray Trojan gRPC     "
echo -e '```'${trojanlink}'```'
echo -e "==============================="
echo -e " Recall Date   : ${hariini}"
echo -e " User Expired  : ${exp}"
echo -e "==============================="
