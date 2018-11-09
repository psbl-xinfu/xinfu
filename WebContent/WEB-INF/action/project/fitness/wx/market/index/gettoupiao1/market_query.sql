select
count(1) as num
from
cc_market_campaign_votelog
where createdby=${fld:wxuserid} and  enrollcode=${fld:toupiaoid} 
and org_id=(select org_id from cc_market_campaign_enroll where code=${fld:toupiaoid})
and status=1
and created::date='${def:date}'::date
and campaigncode=
(select code from
cc_market_campaign m
where
m.status=1  and m.campaigntype=3 and m.org_id=(select org_id from cc_market_campaign_enroll where code=${fld:toupiaoid}))