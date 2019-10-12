 select
 startdate,
 enddate,
 validatetype
from
cc_market_campaign
 where 
 
 org_id=${def:org}
 and 
 code=${fld:code}
