select
count(1) as baomingnum
from
cc_market_campaign_enroll  e
inner join cc_market_campaign m on  m.code=e.campaigncode and m.status=1  and m.campaigntype=3 and m.org_id=${def:org}
where e.org_id=${def:org}
