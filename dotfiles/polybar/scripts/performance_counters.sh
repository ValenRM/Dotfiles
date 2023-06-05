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

	cpu=$(top -b -n1 | grep "Cpu(s)" | awk '{print $2}' | awk -F. '{print $1}')
	mem=$(free | awk '/Mem/{printf("%d", $3/$2*100.0)}')

	if [ $t -eq 0 ]; then
		if [ $cpu -lt 35 ] && [ $mem -lt 45 ]; then
			echo ""
		else
			echo ""
		fi
	else
		echo "󰍛 $cpu%   $mem%"
	fi
	sleep 1 &
	sleep_pid=$!
	wait
done

