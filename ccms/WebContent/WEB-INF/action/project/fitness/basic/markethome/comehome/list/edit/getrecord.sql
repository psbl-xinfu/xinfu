select	
code,
campaign_name,
expercardcode,
totalnum,
personnum,
validatetype,
startdate,
enddate,
rankrules,
link,
campaignrules,
status
from 
	cc_market_campaign
where 
	code = ${fld:id};
