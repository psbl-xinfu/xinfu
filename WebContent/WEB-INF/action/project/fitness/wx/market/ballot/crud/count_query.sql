select
count(1) as toupiaonum,
(select cusstname from cc_market_campaign_enroll where code=${fld:id}) as cusstname,
(select descr from cc_market_campaign_enroll where code=${fld:id}) as descr
from
cc_market_campaign_votelog  
where org_id=(select org_id from cc_market_campaign_enroll where code=${fld:id}  )
and enrollcode=${fld:id}
