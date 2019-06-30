flePth:system"pwd"
system"l ",("/" sv flePth,-1_"/" vs string .z.f),"/schema.q"

vals:.Q.opt[.z.x]

tabName:first `$vals[`table]
colTyp:exec t from meta tabName

tab:value flip (colTyp;enlist csv) 0:hsym first `$vals[`file]

h:hopen first "J"$.Q.opt[.z.x][`port]
h(".u.upd";tabName;tab)


