select
    code,
    campaign_name,
    startdate,
    enddate,
    discount,
    org_id,
    cardtype,
    remark
from 
	cc_campaign
where 
	code = ${fld:id}
	and org_id = ${def:org}
