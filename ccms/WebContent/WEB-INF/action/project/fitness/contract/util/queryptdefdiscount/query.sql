select 
	reate
from cc_ptdef_discount
where ptdefcode = ${fld:ptlevelcode}
and startcount<=${fld:ptcount} and endcount>=${fld:ptcount}
and org_id = ${def:org}
order by code limit 1
