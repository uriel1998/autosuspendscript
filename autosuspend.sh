#!/bin/bash

battdoing=$(acpi -b | awk -F " " '{print $3}' | awk -F "," '{print $1}')
if [ "$battdoing" != "Charging" ]; then
	battstate=$(acpi -b | awk -F " " '{print $4}' | awk -F "%" '{print $1}')

	if [ $battstate -le 10 ]; then
		if [ $battstate -le 5 ]; then
			DISPLAY=:0.0 zenity --timeout 5 --question --text "Battery at less than 5%; HIBERNATING NOW"
			if [ "$?" -eq "0" ];then
				sudo pm-suspend-hybrid
			fi
		fi

		DISPLAY=:0.0 zenity --timeout 30 --question --text "Battery at less than 10%; suspend now?"
		if [ "$?" -eq "0" ];then
			sudo pm-suspend
		fi
	fi
fi
