t=0
sleep_pid=0
mode=$(nmcli device show | grep -q "WIRE")

toggle() {
    t=$(((t + 1) % 2))

    if [ "$sleep_pid" -ne 0 ]; then
        kill $sleep_pid >/dev/null 2>&1
    fi
}

trap "toggle" USR1

while true; do
	if [ $t -eq 0 ]; then

		charge=$(cat /sys/class/power_supply/BAT?/capacity 2>/dev/null)
		status=$(cat /sys/class/power_supply/BAT?/status 2>/dev/null)

		if [[ "$status" == "Charging" || "$status" == "Full" || "$status" == "Not charging" ]]; then
			color="#88C0D0"
		elif [[ $charge -lt 20 ]]; then
			color="#BF616A"
		else
			color="#ccffffff"
		fi

		if [[ $charge -lt 15 ]]; then
			echo "%{F$color} "
		elif [[ $charge -lt 35 ]]; then
			echo "%{F$color} "
		elif [[ $charge -lt 60 ]]; then
			echo "%{F$color} "
		elif [[ $charge -lt 80 ]]; then
			echo "%{F$color} "
		else
			echo "%{F$color} "
		fi
	else
		if [[ $charge -lt 15 ]]; then
			echo "%{F$color}  $charge%"
		elif [[ $charge -lt 35 ]]; then
			echo "%{F$color}  $charge%"
		elif [[ $charge -lt 60 ]]; then
			echo "%{F$color}  $charge%"
		elif [[ $charge -lt 80 ]]; then
			echo "%{F$color}  $charge%"
		else
			echo "%{F$color}  $charge%"
		fi
	fi
	sleep 1 &
	sleep_pid=&!
	wait
done
