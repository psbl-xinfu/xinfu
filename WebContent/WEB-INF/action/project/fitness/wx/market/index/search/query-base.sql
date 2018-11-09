select
code,
enrollname,
(select count(1) from cc_market_campaign_votelog log where  log.enrollcode=cc_market_campaign_enroll.code and org_id=${def:org})as num,
(select tuid from t_attachment_files  where pk_value=(select code from cc_customer where mobile=cc_market_campaign_enroll.mobile and org_id=${def:org})

and table_code='cc_customer' limit 1 )as tuid
from
cc_market_campaign_enroll
where
 status=2 and org_id=${def:org} 
 
 
 ${filter}