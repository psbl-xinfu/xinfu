select	
code,
campaign_name,
(select name from  cc_expercard where  code=cc_market_campaign.expercardcode and org_id=${def:org}) as expercardname,
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
