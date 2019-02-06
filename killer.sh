#!/bin/bash
echo "KILLALL STARTED"
/usr/bin/killall -9 youtube-dl
/usr/bin/killall -9 ffmpeg
/usr/bin/killall -9 mpg123
exit 0
