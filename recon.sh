#!/bin/bash
#by T, with help from TCM
#Recon Tool, whois, Findsubdomains, see if subdomains are alive, and take screenshots

domain=$1
RED="\033[1;31m"
RESET="\33[0M"

info_path=$domain/info
subdomain_path=$domain/subdomains
screenshot_path=$domain/screenshot



if [ ! -d "$domain" ]; then
	mkdir $domain
fi

if [ ! -d "$info_path" ]; then
	mkdir $info_path
fi

if [ ! -d "$subdomain_path" ]; then
	mkdir $subdomain_path
fi

if [ ! -d "$screenshot_path" ]; then
	mkdir $screenshot_path
fi

echo -e "${RED} [+] Checking Who It Is ... ${RESET}"
whois $1 > $subdomain_path/whois.txt

echo -e "${RED} [+] Launching Subfinder ... ${RESET}"
subfinder $1 $domain > $subdomain_path/found.txt
#FIX:
echo -e "${RED} [+] Assetfinder ... ${RESET}"
assetfinder $domain | grep $domain >> $subdomain_path/found.txt

#Removed for efficiency
#echo -e "${RED} [+] Checking AMASS ... This Could Take A While ${RESET}"
#whois $1 > $domain > $subdomain_path/found.txt

echo -e "${RED} [+] Checking Who Is Alive ... ${RESET}"
cat $subdomain_path/found.txt | grep $domain | sort -u | httprobe -prefer-https | grep https | sed 's/https\?:\/\///' | tee -a $subdomain_path/alive.txt

#Removed for now
#echo -e "${RED} [+] Taking Screenshots ... ${RESET}"
#gowithness file -f $subdomain_path/alive.txt -P $screenshot_path/ --no-http
