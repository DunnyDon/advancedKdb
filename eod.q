quote:([]time:`timespan$();sym:`$();bid:`float$();ask:`float$();askSize:`long$();bidSize:`long$();exchange:`$())
bid:([]time:`timespan$();sym:`$();price:`float$();size:`long$();exchange:`$())
statsTab:([]time:`timespan$();sym:`$();maxPrice:`float$();minPrice:`float$();volume:`long$();maxBid:`float$();lowAsk:`float$())
upd:insert
vals:.Q.opt[.z.x]
tpLog:first hsym`$vals[`tpLog]
dts:first "D"$vals[`date]
.z.zd:(17;2;6)
-11!tpLog
.Q.hdpf[`::;`:hdb;dts;`sym]
\x .z.zd
times:system"find . -name \"time\" -print |grep ",string dts
symFles:system"find . -name \"sym\" -print |grep ",string dts
uncompress:{fle:hsym`$x;fle set get fle}
uncompress@/:symFles
uncompress@/:times
0N!"Log Replay completed!";
