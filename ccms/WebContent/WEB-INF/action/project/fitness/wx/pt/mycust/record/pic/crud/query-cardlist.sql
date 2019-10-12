select
count(1) as usenum
from
cc_expercard_list
where
market_campaign_code=(
	select code from cc_market_campaign  
	where  status=1 and campaigntype=0 and org_id = ${def:org}
) and org_id =${def:org}
