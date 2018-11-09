select
code,
campaign_name,



validatetype,
startdate,
enddate,

link,
campaignrules,
status
from 
	cc_market_campaign
where 
	code = ${fld:id};
