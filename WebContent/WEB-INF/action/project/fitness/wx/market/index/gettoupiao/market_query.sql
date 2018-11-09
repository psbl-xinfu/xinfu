select
m.votetype,
m.votenum,
(case when m.enddate::date>= {ts'${def:timestamp}'}::date then 0 else 1 end  )as status
from 
cc_market_campaign m
where
m.status=1  and m.campaigntype=3 and m.org_id=(select org_id from cc_market_campaign_enroll where code=${fld:toupiaoid})