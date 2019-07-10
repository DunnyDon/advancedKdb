/Allows users to load in TPLog file and save data to disk compressed (except time and sym)
/Usage
/q eod.q -tpLog ../tpLogs/schema2019.06.24 -date 2019.06.24

/Assumes the schema script used by the TP is underneath where command is being run from
/Dynamically finds the schema script and loads it in

flePth:system"pwd"
system"l ",("/" sv flePth,-1_"/" vs string .z.f),"/schema.q"

/set upd function
upd:insert

/get user inputted vals
vals:.Q.opt[.z.x]
tpLog:first hsym`$vals[`tpLog]
dts:first "D"$vals[`date]

/set compression vals
.z.zd:(17;2;6)

/read in tpLog and save to disk
-11!tpLog
.Q.hdpf[`::;`:hdb;dts;`sym]

/expunge compression settings
\x .z.zd

/get time and sym column
times:system"find . -name \"time\" -print |grep ",string dts
symFles:system"find . -name \"sym\" -print |grep ",string dts
uncompress:{fle:hsym`$x;fle set get fle}

/read back in the files and write back down uncompressed
uncompress@/:symFles
uncompress@/:times
0N!"Log Replay completed!";
