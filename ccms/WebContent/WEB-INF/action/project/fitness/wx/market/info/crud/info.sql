select
m.remark,
m.enrollfdate,
m.enrolltdate,
m.voteremark
from
 cc_market_campaign m
 where
  m.status=1  and m.campaigntype=3 and m.org_id=${def:org}
