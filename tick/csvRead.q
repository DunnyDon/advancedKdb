/Allows users to load in csv file and publish to TP
/Usage
/q csvRead.q -file bid.csv -table bid -port

/Assumes the schema script used by the TP is underneath where command is being run from
/Dynamically finds the schema script and loads it in

flePth:system"pwd"
system"l ",("/" sv flePth,-1_"/" vs string .z.f),"/schema.q"

/read in user definied params
vals:.Q.opt[.z.x]

/get schema types
tabName:first `$vals[`table]
colTyp:exec t from meta tabName

/read in csv file and apply column types
tab:value flip (colTyp;enlist csv) 0:hsym first `$vals[`file]

/open handle to TP, port specified by user
/publish data to TP
h:hopen first "J"$.Q.opt[.z.x][`port]
h(".u.upd";tabName;tab)


