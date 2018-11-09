select 
	code as sitedefcode,
	sitename
from cc_sitedef
where sitetype = (select sitetype from cc_sitedef where code = ${fld:sitecode} and org_id = ${def:org})
and org_id = ${def:org} and code!=${fld:sitecode}