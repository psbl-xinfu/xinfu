select 
	code as sitedefcode,
	sitename as stname
from cc_sitedef
where sitetype = (select sitetype from cc_sitedef where code = ${fld:code} and org_id = ${def:org})
and org_id = ${def:org} and code!=${fld:code}