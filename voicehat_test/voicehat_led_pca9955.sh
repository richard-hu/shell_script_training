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

echo -e $GREEN***********************************
echo '      LED Testing '
echo -e ***********************************$NC

LEDS=( $(find /sys/class/leds/ -name "pca995x*" | sort) )

if [ -z "$LEDS" ]; then
    echo -e $RED Can not find PCA995X in sysfs! $NC
    exit 1
fi

for i in {1..10}; do
        for LEDS in ${LEDS[@]}; do
                echo 255 >  "$LEDS"/brightness
                usleep 10000

                echo 0 > "$LEDS"/brightness
        done
done