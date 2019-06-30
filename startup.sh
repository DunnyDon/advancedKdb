#!/bin/bash

newtab () {
	gnome-terminal --window -t $1 --working-directory $3 -- $2  
	echo"$3 $2"
	echo "$1 has started up."
	sleep 3
 }


runAll () {
	newtab "tick" "q tick.q schema tpLogs/ -p 5000" $1
	newtab "feed" "q feedHandler.q :5000" $1
	newtab "rdbStats"  "q tick/r.q localhost:5000 -tables statsTab -p 5002" $1
	newtab "Stats"  "q tick/c.q :5000" $1
	newtab "rdb" "q tick/r.q localhost:5000 -tables bid,quote -p 5003" $1

}

#runAll "/home/cdonohue/Desktop/advancedKdb"

for ARGUMENT in "$@"
do

   KEY=$(echo $ARGUMENT | cut -f1 -d=)
   VALUE=$(echo $ARGUMENT | cut -f2 -d=)

   case "$KEY" in
           COMPONENT)              COMPONENT=${VALUE} ;;
           PORT)                   PORT=${VALUE} ;;
           CONNECT_TO)             CONNECT_TO=${VALUE};;
	   WORKING_DIR)		   WORKING_DIR=${VALUE};;
           TABLES)		   TABLES=${VALUE};;
           *)
   esac


done

echo "Component = $COMPONENT"
echo "Port = $PORT"
echo "TP is on port $CONNECT_TO"

declare -A SCRIPTS=(["rdb"]="tick/r.q" ["tick"]="tick.q" ["cep"]="tick/c.q" ["feed"]="feedHandler.q")

if [ -z "$COMPONENT" ]
then
       while true; do
               read -p "No specific element specifed to start do you wish to start all?? (y/n)" yn
               case $yn in
                       [Yy]* ) runAll "/home/cdonohue/Desktop/advancedKdb";exit;;
                       [Nn]* ) echo "Please enter valid params"; exit;;
                       *) echo "Please answer yes or no";;
               esac
       done
else
       if [ -n "$PORT" ] 
       then 
	       pPort="-p $PORT" 
       fi

       if [ -n "$TABLES" ] 
       then 
	       pTables="-tables $TABLES" 
       fi
       newtab $COMPONENT "q ${SCRIPTS[$COMPONENT]} $CONNECT_TO $pPort $pTables" $WORKING_DIR
fi


