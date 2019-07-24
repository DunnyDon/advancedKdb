#!/bin/bash
#Script which allows user to start up all components or individual components
#Usage:
#./startup.sh COMPONENT="rdb" PORT="5001" 
#Working_Dir specified where the scripts are kept
#Function to run command in a new cmd Tab

#Function to run all components with default values
runAll () {
	nohup q tick.q schema tpLogs/ -p 5000 > /dev/null 2>&1 &
	nohup q tick/feedHandler.q :5000 > /dev/null 2>&1 &
	nohup q tick/r.q localhost:5000 -tables statsTab -p 5002 > /dev/null 2>&1 &
	nohup q tick/c.q :5000 -p 5003 > /dev/null 2>&1 &
	nohup q tick/r.q localhost:5000 -tables bid,quote -p 5001 > /dev/null 2>&1 &

}

#Map user enetered params to variables
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
#Display component for user to see
echo "Component = $COMPONENT"
echo "Port = $PORT"
echo "TP is on port $CONNECT_TO"

declare -A SCRIPTS=(["rdb"]="tick/r.q" ["tick"]="tick.q" ["cep"]="tick/c.q" ["feed"]="tick/feedHandler.q")
#If no component is set user is offered chance to run everything with default values
if [ -z "$COMPONENT" ]
then
       while true; do
               read -p "No specific element specifed to start do you wish to start all?? (y/n)" yn
               case $yn in
                       [Yy]* ) runAll ;exit;;
                       [Nn]* ) echo "Please enter valid params"; exit;;
                       *) echo "Please answer yes or no";;
               esac
       done
else
	#If a port is entered then set, same with tables to subscribe to
       if [ -n "$PORT" ] 
       then 
	       pPort="-p $PORT" 
       fi

       if [ -n "$TABLES" ] 
       then 
	       pTables="-tables $TABLES" 
       fi
        nohup q ${SCRIPTS[$COMPONENT]} $CONNECT_TO $pPort $pTables > /dev/null 2>&1 &
fi


