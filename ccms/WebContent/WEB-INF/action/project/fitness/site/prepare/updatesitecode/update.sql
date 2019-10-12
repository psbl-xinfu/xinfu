update cc_siteusedetail 
set 
	sitecode=${fld:hcsitedef},
	sitechange=${fld:tcsitechange},
	updatedby='${def:user}',
	updated={ts '${def:timestamp}'}
where
	code = ${fld:hccode} and org_id = ${def:org}

	
