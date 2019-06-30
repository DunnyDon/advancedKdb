quote:([]time:`timespan$();sym:`$();bid:`float$();ask:`float$();askSize:`long$();bidSize:`long$();exchange:`$())
bid:([]time:`timespan$();sym:`$();price:`float$();size:`long$();exchange:`$())
statsTab:([]time:`timespan$();sym:`$();maxPrice:`float$();minPrice:`float$();volume:`long$();maxBid:`float$();lowAsk:`float$())

vals:.Q.opt[.z.x]

tabName:first `$vals[`table]
colTyp:exec t from meta tabName

tab:value flip (colTyp;enlist csv) 0:hsym first `$vals[`file]

h:hopen first "J"$.Q.opt[.z.x][`port]
h(".u.upd";tabName;tab)


