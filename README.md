# kdb+tick

Files previously at code.kx.com/wsvn/kx/kdb+tick


## Hot-linking

You are welcome to download and use this code according to the terms of the licence. 

Kx Systems recommends you do not link your application to this repository, 
which would expose your application to various risks:

- This is not a high-availability hosting service
- Updates to the repo may break your application 
- Code refactoring might return 404s to your application

Instead, download code and subject it to the version control and regression testing 
you use for your application.
#Advanced kdb+ 

#USAGE

#Start All

./startup.sh

#Start One Component

./startup.sh  COMPONENT=rdb PORT=5001 WORKING_DIR="/home/cdonohue/advancedKdb"

#Stop All

./stop.sh

#Stop one Component

./stop.sh COMPONENT="tick" PORT="5003"

#Log Replay

q logReplay.q -newLog tpTest -tpLog ../tpLogs/schema2019.06.21 

#CSV read and publish to TP

q csvRead.q -file bid.csv -table bid -port 5000

#EOD Run

q eod.q -tpLog ../tpLogs/schema2019.06.24 -date 2019.06.24


