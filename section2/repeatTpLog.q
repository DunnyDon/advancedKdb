`:newtp set ()
upd:insert
h:hopen `:newtp
vals:get`:tplog
castDict:`sym`price`size!(($;enlist`;((/:;#);1;`sym));($;enlist`float;`price);($;enlist`long;`size))
check:{
	tmp:x 2;
	if[98h=type tmp;
	$[0<>count cls:kys!castDict[kys:(exec c from meta tmp)@where c:"sfj"<>exec t from meta tmp];
		h enlist(x 0;x 1;![tmp;();0b;cls]);
		h enlist(x 0;x 1;tmp)]
	]}

check each vals
