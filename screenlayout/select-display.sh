external=/sys/class/drm/card0-HDMI-A-1/status

prev=""

# while inotifywait -e modify,create,delete,open,close,close_write,access $external
while true
do
    status="`cat $external`"
    if [ "$status" != "$prev" ]
    then
        if [ $status = 'disconnected' ]
        then
            ~/.screenlayout/one-screen.sh
        else
            ~/.screenlayout/both-screens.sh
        fi
        prev=$status
    fi
    sleep 5
done
