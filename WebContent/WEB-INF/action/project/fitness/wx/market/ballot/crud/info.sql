select
enddate,
votenum
from
cc_market_campaign  
where
status=1  and campaigntype=3 and org_id=(select org_id from cc_market_campaign_enroll where code=${fld:id}  )