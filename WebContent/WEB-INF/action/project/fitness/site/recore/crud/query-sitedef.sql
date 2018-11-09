select
	code,
	sitename
from cc_sitedef
where status=1 and org_id = ${def:org}