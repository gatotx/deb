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
echo -e "${red}IP ANDA TIDAK DIDAFTARKAN , HUBUNGI SAYA @Jo3k3r UNTUK BANTUAN${NC}"
sleep 0.5
exit
fi
data=( `cat /etc/shadowsocks-libev/akun.conf | grep '^###' | cut -d ' ' -f 2`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^### $user" "/etc/shadowsocks-libev/akun.conf" | cut -d ' ' -f 3)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
printf "$user\n$exp2\n" | add-ss
done
rm -f /etc/shadowsocks-libev/ss.conf
data=( `cat /etc/wireguard/wg0.conf | grep '^### Client' | cut -d ' ' -f 3`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
chmod 777 /home/vps/public_html/$user.conf
done