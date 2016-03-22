STATE=$(mpc status | awk '/\[/ { print $1 }')

if [ "$STATE" = "[playing]" ]
then
    mpc -q pause;
    echo  > ~/.i3/scripts/mpc_icon.txt
elif [ "$STATE" = "[paused]" ]
then
    mpc -q play;
    echo  > ~/.i3/scripts/mpc_icon.txt
else
    mpc -q play;
    echo  > ~/.i3/scripts/mpc_icon.txt
fi

