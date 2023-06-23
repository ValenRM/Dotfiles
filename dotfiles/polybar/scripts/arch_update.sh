normal="#88C0D0"
few_packages="#a3be8c"
update="#d08770"
urgent="#b94550"
packages=$(pacman -Qu | wc -l)


if [ $packages -eq 0 ]; then
	echo "%{F$normal}󰣇 "
elif [ $packages -lt 5 ]; then
	echo "%{F$few_packages}󰣇 󰅃"
elif [ $packages -lt 10 ]; then
	echo "%{F$update}󰣇 󰄿"
elif [ $packages -ge 10 ]; then
	echo "%{F$urgent}󰣇 󰶼"
fi
