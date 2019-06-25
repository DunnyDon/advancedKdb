#!/bin/bash
for ARGUMENT in "$@"
do

   KEY=$(echo $ARGUMENT | cut -f1 -d=)
   VALUE=$(echo $ARGUMENT | cut -f2 -d=)

   case "$KEY" in
           COMPONENT)              COMPONENT=${VALUE} ;;
           PORT)                   PORT=${VALUE} ;;
           *)
   esac


done
declare -A SCRIPTS=(["rdb"]="tick/r.q" ["tick"]="tick.q" ["cep"]="tick/c.q" ["feed"]="feedHandler.q")
if [ -z "$COMPONENT" ]
then
       while true; do
               read -p "No specific element specifed to stop do you wish to stop all?? (y/n)" yn
               case $yn in
                       [Yy]* )kill $(ps -u "$(whoami)" -elf | grep "\.q" |grep -v grep |awk '{print $4}');exit;;
                       [Nn]* ) echo "Please enter a valid param. Ex ./stop.sh COMPONENT=rdb"; exit;;
                       *) echo "Please answer yes or no";;
               esac
       done
else
	if [ -z "$PORT" ]
	then
		kill $(ps -u "$(whoami)" -elf | grep "\.q" |grep -v grep |grep "${SCRIPTS[$COMPONENT]}" |awk '{print $4}')
	else 
		kill $(ps -u "$(whoami)" -elf | grep "\.q" |grep -v grep |grep "${SCRIPTS[$COMPONENT]}" |grep "$PORT" |awk '{print $4}')
	fi
fi
