#!/bin/bash    
fifo_name="/var/www/sr/_gen/streamingriver"
if [ ! -p $fifo_name ]; then
  mkfifo $fifo_name
fi

while true
do
	cat $fifo_name
        /opt/tools/up.py
        /opt/tools/after.sh
done
