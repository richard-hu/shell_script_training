#!/bin/sh
FILE_UP=/count_usb_up
FILE_DOWN=/count_usb_down

if [ ! -f  $FILE_UP ] ; then
    echo 0 > $FILE_UP
fi

if [ ! -f  $FILE_DOWN ] ; then
    echo 0 > $FILE_DOWN
fi

if [ -b /dev/sda ];then
  count=`cat $FILE_UP`
  echo "USB stick is detected:"
  echo $(($count+1)) | tee $FILE_UP
  echo "USB stick is not detected:"
  echo $(cat $FILE_DOWN)
else
  count=`cat $FILE_DOWN`
  echo "USB stick is not detected:"
  echo $(($count+1)) | tee $FILE_DOWN
fi
sleep 1
sync
