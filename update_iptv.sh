#!/bin/bash

url="https://www.dailyiptvlist.com/portugal-iptv-smarters-free-m3u-lists-";
day=$(date | cut -f2 -d ' ');
month=$(date | cut -f3 -d ' ');
year=$(date | cut -f4 -d ' ');

final_url="${url}${day}-${month}-${year}";

x="";
url_iptv=$(curl $final_url | grep "https://dailyiptvlist.com/dl/pt-" | grep -v '"');
iptv_urls=${url_iptv/\<pre\>/"$x"};

mkdir -p IPTV_List

while IFS= read -r line ; do wget -q -N $line -P IPTV_List/; done <<< "$iptv_urls";

cat IPTV_List/* > IPTV_List/IPTV_ALL.m3u ; 

rm IPTV_List/pt* 



