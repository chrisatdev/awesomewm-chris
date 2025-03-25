#!/bin/sh

exec xautolock -time 10 -locker '/usr/share/i3lock-fancy/lock -t Locked' -- scrot
