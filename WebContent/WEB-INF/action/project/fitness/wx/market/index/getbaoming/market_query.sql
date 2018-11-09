select
m.totalnum,
(case when m.enrolltdate::date>= {ts'${def:timestamp}'}::date then 0 else 1 end  )as status,
(select count(1) from cc_market_campaign_enroll e where m.code=e.campaigncode  and e.status=2 and e.org_id=${def:org}  )as num,
(select count(1) from cc_market_campaign_enroll e where m.code=e.campaigncode  and e.status=2 and e.org_id=${def:org} and createdby='${def:user}' )as isbaoming
from 
cc_market_campaign m
where
m.status=1  and m.campaigntype=3 and m.org_id=${def:org}