select 
	cardid
	,age
	,stature
	,sex
	,testdate
	,avoirdupois
	,tzf
	,tzf_bfb
	,ytzf_bfb
	,ggj
	,stzl_cs
	,jkpg
from smtec_health
where 1=1
and (select card.code from cc_card card where card.customercode=${fld:vc_custcode} and card.org_id = ${def:org} and card.isgoon =0 )=smtec_health.cardid
and to_date(testdate,'yyyy-mm-dd')=${fld:date}
order by jkpg desc 
limit 1