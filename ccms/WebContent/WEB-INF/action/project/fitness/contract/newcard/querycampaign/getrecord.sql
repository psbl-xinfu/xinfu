select
	code,
	campaign_name,
	discount 
from cc_campaign
where is_enabled = 1 
and (startdate <= {d'${def:date}'} or startdate is null) 
and (enddate >= {d'${def:date}'} or enddate is null) 
and (cardtype = ${fld:cardtype} or cardtype is null or cardtype = '') 
and (org_id = ${def:org} OR org_id IS NULL)
