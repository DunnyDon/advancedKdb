#!/bin/bash
#while getopts component:ports:table:logdir: option
#do
#case "${option}"
#in
#component) COMP=${OPTARG};;
#ports) PORT=${OPTARG};;
#table) TAB=${OPTARG};;
#f) FORMAT=$OPTARG;;
#esac
#done



#declare -A components
#components


#osascript << END
newtab () {
	gnome-terminal --window -t $1 --working-directory $3 -- $2  
	echo "$1 has started up."
	sleep 3
 }


runAll () {
	newtab "tick" "q tick.q schema tpLogs/ -p 5000" $1
	newtab "feed" "q feedHandler.q " $1
	newtab "rdbStats"  "q tick/r.q localhost:5000 -tables statsTab -p 5002" $1
	newtab "Stats"  "q tick/c.q :5000" $1
	newtab "rdb" "q tick/r.q localhost:5000 -tables bid,quote -p 5003" $1

}

runAll "/home/cdonohue/Desktop/advancedKdb"



