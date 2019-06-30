flePth:system"pwd"
system"l ",("/" sv flePth,-1_"/" vs string .z.f),"/schema.q"
upd:{[t;x]if[t=`bid;z:x[;x[1;]?`IBM];y:flip (cols value t)!$[all 1=count each z;enlist each z;z];h:hopen tpFle;h enlist(`upd;t;y);hclose h;.ctd.x:x;.ctd.t:t]}

vals:.Q.opt[.z.x]
tpFle:first hsym `$vals[`newLog]
tpFle set()
-11!first hsym `$vals[`tpLog]


