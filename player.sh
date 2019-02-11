#!/bin/bash
function timer() { 
	sleep 900; echo killed; killall -9 youtube-dl; killall -9 mpg123;
}

function autoupdate() {
	while true; do youtube-dl -U; sleep 500; done
}

FILTER_WORDS="s/(HD|Amazing Quality)//ig"

QUEUE_SERVER=""
#trap "tput clear; echo lol" SIGINT SIGTERM
amqp-consume -u $QUEUE_SERVER -q skip-queue ./killer.sh &
autoupdate&
while true
do
#	tput clear
	pause=`amqp-get -u $QUEUE_SERVER -q pause-queue`
	if [[ $? -eq 0 && $pause -gt 0 ]]
	then
		echo "SLEEPING FOR $pause SECONDS"
		sleep $pause
	fi
	timer&
	timer_pid=$!
	bazars=`amqp-get -u $QUEUE_SERVER -q papizdelink`
	if [[ $? -eq 0 && $bazars != "" ]]
	then
	    espeak -a 100 -s 120 -g 5 "$bazars"
	fi 
	echo "TIMER PID: $timer_pid"
	video=`amqp-get -u $QUEUE_SERVER -q youtube-playlist-queue`
	if [[ $? -gt 0 || $video == "" ]]
	then
		echo -e "\033[31;1mFailed to get video from queue, falling back to idle queue\033[37;1m"
		video=`amqp-get -u $QUEUE_SERVER -q idle-queue`
	fi
	if [[ $video != "" ]]
	then
		echo -e "\033[32mPlaying video $video\033[37;1m"
		espeak -a 100 -s 120 -g 5 "`wget -q -O - https://www.youtube.com/watch?v=$video | grep 'title>' | sed 's/title>\(.*\)<\/title.*/\1/g' | tr -d '<>' | sed 's/- youtube//gi'` | sed '$FILTER_WORDS'"
		youtube-dl https://www.youtube.com/watch?v=$video -o - | mbuffer -m 1024M | ffmpeg -i - -bufsize 1024M -f mp3 -ab 256000 -vn - | mpg123 - 
		if [[ $? -eq 0 ]]
		then
			echo -e "\033[32mAdding video to idle queue\033[37;1m"
			amqp-publish -u $QUEUE_SERVER -e idle-queue -r idle-queue -p -b $video
		fi
	else
		echo -e "\033[31;1mAll queues empty, sleeping...\033[37;1m"
		sleep 5
	fi
	kill -9 $timer_pid
	killall sleep
done
exit 0
