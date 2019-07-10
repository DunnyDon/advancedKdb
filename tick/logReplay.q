/This script lets a user load in a tplog to the current session and creates a new TP for only IBM
/Usage
/q logReplay.q -newLog tpTest -tpLog ../tpLogs/schema2019.06.24

/Assumes the schema script used by the TP is underneath where command is being run from
/Dynamically finds the schema script and loads it in
flePth:system"pwd"
system"l ",("/" sv flePth,-1_"/" vs string .z.f),"/schema.q"

/set custom upd function to be used when -11! is called
upd:{[t;x]
	/check to see if table is bid and if any syms are IBM
	/if they are format data and write to tpLog
	if[t=`bid;
		z:x[;x[1;]?`IBM];
		y:flip (cols value t)!$[all 1=count each z;enlist each z;z];
		h:hopen tpFle;
		h enlist(`upd;t;y);
		hclose h;
		.ctd.x:x;
		.ctd.t:t
	]}


/read in user definied vars and replay tpLog
vals:.Q.opt[.z.x]
tpFle:first hsym `$vals[`newLog]
tpFle set()
-11!first hsym `$vals[`tpLog]


