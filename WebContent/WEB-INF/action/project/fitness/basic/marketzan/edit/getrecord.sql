select	
code,
startdate,
enddate,
votetype,
votenum,
campaignrules,
campaign_name,
remark,

enrollfdate,
enrolltdate,
voteremark,
totalnum,
logoid
from 
	cc_market_campaign
where 
	code = ${fld:id};
