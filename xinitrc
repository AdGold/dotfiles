#Set urxvt settings
xrdb -merge ~/.Xresources
#Start i3
exec /usr/bin/i3 >> ~/.i3/stdout 2>> ~/.i3/stderr
