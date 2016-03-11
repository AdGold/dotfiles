external=/sys/class/drm/card0-HDMI-A-1/status

while inotifywait -e modify,create,delete,open,close,close_write,access $external
do
    if [ `cat $external` = 'disconnected' ]
    then
        ~/.screenlayout/one-screen.sh
    else
        ~/.screenlayout/both-screens.sh
    fi

done
