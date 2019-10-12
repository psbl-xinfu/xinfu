select
count(1) as toupiaonum
from
cc_market_campaign_votelog  v
inner join cc_market_campaign m on  m.code=v.campaigncode and m.status=1  and m.campaigntype=3 and m.org_id=${def:org}
where v.org_id=${def:org}
