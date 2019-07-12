#Advanced kdb+ 

This repo contains a tickerplany set up with supporting scripts and components. The core .u functionality that comes from the kx Github has been modified and changed to allow for extra functionality such as log replay and statisical logging functionality

This repo contains bash scripts which allow users to see what processes are online, to start/stop individual or sets of processes. 

The tick architecture in this project includes two rdbs and a cep engine which performs realtime aggregation statistics and publishes this back to the tickerplant

There is also a HTML web interface to allow users to query the data in real time
Futhermore there are 2 feedhandlers which are written in other programming languages, Java and Python, and allow for the publishing of data to a TP

#Dependencies

To run kdb+ you will require a kdb+ license. This is available for non-commercial use accross all major OS and can be downloaded for free at either of the links below

https://anaconda.org/kx/jupyterq
https://kx.com/connect-with-us/download/

At this link you can download 32bit (offline) or 64 (on demand, you will require an active internet connection to run this)

Further Dependencies include python3 and qpython. Links for both can be found below 

https://www.python.org/downloads/
https://conda.io/projects/conda/en/latest/user-guide/install/index.html

https://pypi.org/project/qPython/

This repo is available for anyone to take and use

Below you can examples of how to run the individual components of this repo

#USAGE

#Start All

./startup.sh

#Start One Component

./startup.sh  COMPONENT=rdb PORT=5001 WORKING_DIR="/home/cdonohue/Desktop/advancedKdb" CONNECT_TO=":5000"

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

#Python Feedhandler

python csvRead.py 

This run on the assumption that the TP is on port 5000. The file to load in is currently hardcoded. Future work would be to make this more flexible


#Java Feedhandler

javac javaFeed.java

java javaFeed

This run on the assumption that the TP is on port 5000. The file to load in is currently hardcoded. Future work would be to make this more flexible

