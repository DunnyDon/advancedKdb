/Script to create dummy data and publish to tp
/Port of Tp specified by user

getask:{[s] prices[s]+getmovement[s]};
getbid:{[s] prices[s]-getmovement[s]};
getmovement:{[s]rand[0.0001]*prices[s]};
getprice:{[s] prices[s]+:rand[1 -1]*getmovement[s]; prices[s]};
h:neg hopen `$raze":",.z.x;
n:2;
flag:1;
syms:`AAPL`MSFT`GOOG`IBM`FDL`CSA`ASX;
prices:syms!(count syms)?400f;
exc:`LDN`NYC`CHI`HK`SYD
.z.ts:{s:n?syms;$[0<flag mod 10;h(".u.upd";`quote;(n#.z.N;s;getbid'[s];getask'[s];n?1000;n?1000;n?exc));h(".u.upd";`bid;(n#.z.N;s;getprice'[s];n?1000;n?exc))];flag+:1;};

\t 1000
