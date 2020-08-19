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
echo '      MIC Testing '
echo -e ***********************************$NC

SPEAKER_CARD=$( aplay -l | grep TFA9912 | cut -d ':' -f 1 | cut -d ' ' -f 2 )
MIC_CARD=$( arecord -l | grep -E 'SPH0645|memsmic' | cut -d ':' -f 1 | cut -d ' ' -f 2 )
TEST_FILE='/tmp/test.wav'

if [ -f  $TEST_FILE ] ; then
    rm $TEST_FILE
fi

if [ -z "$SPEAKER_CARD" ]; then
    echo "Can not find TFA9912 speaker!"
    echo "Test SPH0645 only!"
    echo "Record for 5 sec, observe the volume bar:"
    arecord -Dplughw:$MIC_CARD -c2 -r48000 -fS32_LE -d 5 -vv $TEST_FILE
    exit 0
else
    echo "Record for 5 sec, observe the volume bar, then playback:"
    arecord -Dplughw:$MIC_CARD -c2 -r48000 -fS32_LE -d 5 -vv $TEST_FILE && aplay -Dplughw:$SPEAKER_CARD $TEST_FILE 
fi



