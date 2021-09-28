#!/bin/bash

url="https://www.dailyiptvlist.com/portugal-iptv-smarters-free-m3u-lists-";
#day=$(date | cut -f3 -d ' ');
day=28;
month=$(date | cut -f2 -d ' ');
year=$(date | cut -f6 -d ' ');

final_url="${url}${day}-${month}-${year}";
echo $final_url;
x="";
url_iptv=$(curl $final_url | grep "https://dailyiptvlist.com/dl/pt-" | grep -v '"');
iptv_urls=${url_iptv/\<pre\>/"$x"};

#mkdir -p IPTV_List
#while IFS= read -r line ; do echo "$line"; done <<< "$iptv_urls";
while IFS= read -r line ; do wget -q -N $line -P /temp/Daily_IPTV/IPTV_List/; done <<< "$iptv_urls";

cat IPTV_List/* > /temp/Daily_IPTV/IPTV_List/IPTV_ALL.m3u ; 

rm /temp/Daily_IPTV/IPTV_List/pt* 

git add --all;
git commit -m "$(date)";
git push;


