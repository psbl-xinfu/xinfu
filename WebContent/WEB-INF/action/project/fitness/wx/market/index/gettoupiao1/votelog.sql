select
code
from
cc_market_campaign_votelog
where createdby=${fld:wxuserid} and  enrollcode=${fld:toupiaoid} and org_id=${def:org} and status=1
and created::date='${def:date}'::date
and campaigncode=
(select code from
cc_market_campaign m
where
m.status=1  and m.campaigntype=3 and m.org_id=${def:org})