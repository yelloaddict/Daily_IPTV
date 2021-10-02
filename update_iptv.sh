#!/bin/bash

#update info
git pull;

url="https://www.dailyiptvlist.com/portugal-iptv-smarters-free-m3u-lists-";
day=$(date | cut -f4 -d ' ');
month=$(date | cut -f2 -d ' ');
year=$(date | cut -f7 -d ' ');

final_url=$(curl https://www.dailyiptvlist.com/iptv-europe-m3u-new/portuguese/ | grep 'le"><a href="'|grep "$day-$month-$year" --ignore-case | cut -f4 -d '"');
echo $final_url;
x="";
url_iptv=$(curl $final_url | grep "https://dailyiptvlist.com/dl/pt-" | grep -v '"');
iptv_urls=${url_iptv/\<pre\>/"$x"};

echo $iptv_urls;

if [ ! -z "$iptv_urls" ]
then

#mkdir -p IPTV_List
#while IFS= read -r line ; do echo "$line"; done <<< "$iptv_urls";
while IFS= read -r line ; do wget -q -N $line -P IPTV_List/ ; done <<< "$iptv_urls";
cat IPTV_List/* > IPTV_List/IPTV_ALL.m3u  ; 
rm IPTV_List/pt* ;

git add --all;
git commit -m "$(date)";
git push;

else

echo "Empty";

fi
