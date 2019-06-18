.z.po:{
 `logInfo insert(.z.u;.z.p;.z.w;"." sv string "i"$0x0 vs .z.a;1b);

 }

.z.pc:{
 update active:0b from `logInfo where handle=x,active;

 }

\d .mem
updateMemStats:{`memInfo insert .z.t,.Q.w[]@/:`used`head`peak`syms`symw}
\d .
logInfo:([]name:`$();time:"t"$();handle:"j"$();ipadr:();active:"b"$())
memInfo:([]time:();used:();head:();peak:();syms:();symw:())
