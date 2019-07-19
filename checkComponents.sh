#!/bin/bash
#Shows all q processes running under user account
declare -A SCRIPTS=(["rdb"]="tick/r.q" ["tick"]="tick.q" ["cep"]="tick/c.q" ["feed"]="tick/feedHandler.q")
VAR=$1
if [ -z "$VAR" ]
then
	ps -u "$(whoami)" -elf | grep "\.q" |grep -v grep 

else
	ps -u "$(whoami)" -elf | grep "\.q" |grep -v grep |grep ${SCRIPTS[$1]}

fi
