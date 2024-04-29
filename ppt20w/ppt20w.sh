#!/bin/bash


#check current power limit
slowppt_limit=$(cat /sys/class/hwmon/hwmon6/power1_cap)
fastppt_limit=$(cat /sys/class/hwmon/hwmon6/power2_cap)

#adjust based on value
if [ "$slowppt_limit" -eq 15000000 ]; then 
	echo 20000000 > /sys/class/hwmon/hwmon6/power1_cap
fi

if [ "$fastppt_limit" -eq 15000000 ]; then
	echo 20000000 > /sys/class/hwmon/hwmon6/power2_cap
fi
