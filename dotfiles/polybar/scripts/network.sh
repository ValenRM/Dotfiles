t=0
sleep_pid=0

toggle() {
    t=$(((t + 1) % 2))

    if [ "$sleep_pid" -ne 0 ]; then
        kill $sleep_pid >/dev/null 2>&1
    fi
}

trap "toggle" USR1

while true; do
	if [ $t -eq 0 ]; then

		if nmcli device show | grep -q 'WIRE'; then
			echo "󱎔"
		else 
			echo ""
		fi
	else
		ip=$(nmcli device show | grep IP4.ADDRESS | awk '{print $2}')
		if nmcli device show | grep -q 'WIRE'; then
			echo -e "󱎔 ${ip}"
		else
			echo "$ip WIFI "
		fi
	fi
	sleep 1 &
	sleep_pid=&!
	wait
done
