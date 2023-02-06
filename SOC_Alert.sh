#!/bin/bash

#Log_Analysis Project
#Project:SOC Alert
	#1 Alert when found failed attempt
	#2 During failed attempt, display the IP address that carry out the attempt
	#3 Display the country of the IP(display the country of the attacker)
	
ln=0
loc=/var/log/auth.log
while true
do

	for i in $(cat $loc | awk "NR>$ln" | grep Failed | awk '{print $(NF-3)}')
	do
		ln=$(cat $loc | wc -l)
		C=$(geoiplookup $i | awk '{$1=$2=$3=$4="";print $0}' | sed 's/ //g')
		echo "[!] ALERT: BF DETECTED [date: $(date)] [IP: $i] ([Country: $C])"
	done
	sleep 2
done
