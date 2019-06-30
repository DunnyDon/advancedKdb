.z.po:{
 $[0=count logInfo;
	[`logInfo insert(.z.u;.z.p;.z.w;.z.a;1b);update ipadr:{"." sv string "i"$0x0 vs x}each ipadr from `logInfo];
	`logInfo insert(.z.u;.z.p;.z.w;"." sv string "i"$0x0 vs .z.a;1b)];

 }

.z.pc:{
 update active:0b from `logInfo where handle=x,active;

 }

\d .mem
updateMemStats:{`memInfo insert .z.t,.Q.w[]@/:`used`head`peak`syms`symw}
out:{-1 string[.z.p]," ### INFO ### ",x};
err:{-2 string[.z.p]," ### ERROR ### ",x};
logtoStdOutAndError:{out[x];err[x]}
\d .
logInfo:([]name:`$();time:"p"$();handle:"j"$();ipadr:();active:"b"$())
memInfo:([]time:();used:();head:();peak:();syms:();symw:())
