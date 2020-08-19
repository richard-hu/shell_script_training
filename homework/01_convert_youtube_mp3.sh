#!/bin/bash

WEBLINK=$1

/usr/local/bin/youtube-dl --extract-audio --audio-format mp3 $1
