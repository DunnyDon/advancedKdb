`:newtp set ()
h:hopen `:newtp
vals:get`:tplog
castDict:`sym`price`size!(($;enlist`;((/:;#);1;`sym));($;enlist`float;`price);($;enlist`long;`size))
check:{
	x:x 2;
	if[98h=type x;
	$[0<>count cls:kys!castDict[kys:(exec c from meta x)@where c:"sfj"<>exec t from meta x];
		h enlist(`upd;`trade;![x;();0b;cls]);
		h enlist(`upd;`trade;x)]
	]}

check each vals
