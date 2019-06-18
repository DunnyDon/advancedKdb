/ q tick/c.q {all|..} [host]:port[:usr:pwd]
/ realtime alerts and continuous queries

x:.z.x,count[.z.x]_("last";":5010")
h:hopen`$":",x 0;x@:0

t:`quote`bid;
s:`;
/ high low close volume
.cep.hlcv:([]time:`timespan$();sym:`$();maxPrice:`float$();minPrice:`float$();volume:`long$();maxBid:`float$();lowAsk:`float$());
upd:{[t;x].cep.hlcv:select max time,max maxPrice,min minPrice,max volume,max maxBid,min lowAsk  by sym from(`sym xkey .cep.hlcv) upsert `sym xkey $[not 98h=type x;0#.cep.hlcv;$[any "price"like/: lower string cols x;select time,sym,maxPrice:price,minPrice:price,volume:size from x;select sym,maxBid:bid,lowAsk:ask from x]];res: value flip 0!delete time from .cep.hlcv;if[any count each res;h(".u.upd";`statsTab;res)];};

/ subscribe and initialize
$[`~t;(upd .)each;(upd .)]h(".u.sub";t;s);
.u.end:{@[`.;tables`.;0#];}

 
