#!/bin/sh
FILE_UP=/count_pcie_up
FILE_DOWN=/count_pcie_down


if [ ! -f  $FILE_UP ] ; then
    echo 0 > $FILE_UP
fi

if [ ! -f  $FILE_DOWN ] ; then
    echo 0 > $FILE_DOWN
fi

dmesg | grep 'pcie: Link up'
if [ "$?" == "0" ];then
  count=`cat $FILE_UP`
  echo "PCIE link up"
  echo $(($count+1)) | tee $FILE_UP
  echo "PCIE link down"
  echo $(cat $FILE_DOWN)
fi

dmesg | grep 'phy link never came up'
if [ "$?" == "0" ];then
  count=`cat $FILE_DOWN`
  echo "PCIE link down"
  echo $(($count+1)) | tee $FILE_DOWN
fi
sleep 1 
sync
