#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- icanhazip.com);
echo "Checking VPS"
IZIN=$( curl https://raw.githubusercontent.com/gatotx/deb/main/ipvps.conf | grep $MYIP ) >/dev/null 2>&1
if [ $MYIP = $IZIN ]; then
echo -e "${green}DITERIMA${NC}"
sleep 0.5
else
echo -e "${red}IP ANDA TIDAK DIDAFTARKAN , HUBUNGI SAYA @jo3k3r UNTUK BANTUAN${NC}"
sleep 0.5
exit
fi
echo start
sleep 0.5
source /var/lib/premium-script/ipvps.conf
domain=$(cat /root/domain)
systemctl stop v2ray
systemctl stop v2ray@none
systemctl stop xray
systemctl stop xray@none
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/v2ray/v2ray.crt --keypath /etc/v2ray/v2ray.key --ecc
systemctl start v2ray
systemctl start v2ray@none
systemctl start xray
systemctl start xray@none
echo Done
sleep 0.5
clear 