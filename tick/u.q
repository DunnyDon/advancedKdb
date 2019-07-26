/2008.09.09 .k -> .q
/2006.05.08 add
\d .u
init:{w::t!(count t::tables`.)#()}

del:{w[x]_:w[x;;0]?y};.z.pc:{del[;x]each t};

sel:{$[`~y;x;select from x where sym in y]}

pub:{[t;x]{[t;x;w].ctd.check:(t;x;w);if[count x:sel[x]w 1;(neg first w)(`upd;t;x)]}[t;x]each w t}

add:{$[(count w x)>i:w[x;;0]?.z.w;.[`.u.w;(x;i;1);union;y];w[x],:enlist(.z.w;y)];(x;$[99=type v:value x;sel[v]y;0#v])}

sub:{if[x~`;:sub[;y]each t];if[not all x in t;'x];del[x].z.w;add[;y]@/:x}

end:{(neg union/[w[;;0]])@\:(`.u.end;x)}

\d .utils
check:-1+`second$.z.T;
l:hopen hsym[`$"stats/statsLog_",("" sv ":" vs "" sv "." vs string .z.P),".log"];
getSubs:{"Current Subscribers: \n",.Q.s .u.w}
newLog:{@[hclose;l;()];l::hopen hsym[`$"stats/statsLog_",("" sv ":" vs "" sv "." vs string .z.P),".log"]}

logData:{l (string .z.t)," - ",x,"\n"}

logD:{check::tmp;logData["Records Processed ",string .u.i];logData getSubs[]}
\d .u
