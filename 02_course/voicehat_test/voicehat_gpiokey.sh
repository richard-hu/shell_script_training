#!/bin/bash

#################################################################################
# Copyright 2019 Technexion Ltd.
#
# Author: Richard Hu <richard.hu@technexion.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 2 as
# published by the Free Software Foundation.
#################################################################################

RED='\033[0;31m'
GREEN='\033[36m\n'
NC='\033[0m'

GPIOKEY_EVENT=$(cat /proc/bus/input/devices | grep -A9 'gpio_keys' | grep 'Handlers' | grep -o 'event.')

# Mapping table for button and key code
# Key_code : Printed_name_on_PCB
CODES=( \
"KEY_PREVIOUS:PREV" \
"KEY_PLAY:PLAY" \
"KEY_NEXT:NEXT" \
"KEY_UP:UP" \
"KEY_DOWN:DOWN" \
"KEY_MUTE:MUTE" \
"KEY_SELECT:PAIR" \
"KEY_OK:ACT" \
)
#for key_code in "${CODES[@]}"; do echo "${key_code%%:*} - ${key_code##*:}"; done

echo -e $GREEN***********************************
echo '      Button Testing '
echo -e ***********************************$NC

for key_code in "${CODES[@]}"
do
	echo Please ${key_code##*:} button
	loop=0
	while true
	do
		if [ $loop = '40' ]; then
			echo -e $RED Timeout!!! ${key_code##*:} is NG $NC
			break
		fi

		evtest --query /dev/input/$GPIOKEY_EVENT EV_KEY ${key_code%%:*}
   		if [ $? -eq 10 ]; then
       		echo "${key_code##*:} pressed"
			break
   		fi
		loop=$(expr $loop + 1)
		sleep 0.1
	done
done

exit 0
