#!/bin/bash
lock=/tmp/collect-pi-temp.running
if [ -f $lock ]; then
    echo $0 still running
    exit 1
fi
touch $lock

cpuTemp0=$(cat /sys/class/thermal/thermal_zone0/temp)
cpuTemp1=$(($cpuTemp0/1000))
cpuTemp2=$(($cpuTemp0/100))
cpuTempM=$(($cpuTemp2 % $cpuTemp1))
CPU=$cpuTemp1"."$cpuTempM
GPU=$(/opt/vc/bin/vcgencmd measure_temp | tr -cd '0-9.')
 
#echo CPU=$CPU,GPU=$GPU
# curl -i -XPOST 'http://localhost:8086/write?db=ruuvi' --data-binary 'temperature.pi CPU='$CPU',GPU='$GPU
curl -i -XPOST --cacert /home/pi/git/influxdb-selfsigned.crt \
    -u energymon:qualm-altruist-hued \
    'https://energy-influxdb:8086/write?db=ruuvi' --data-binary 'temperature.pi CPU='$CPU',GPU='$GPU

rm $lock
