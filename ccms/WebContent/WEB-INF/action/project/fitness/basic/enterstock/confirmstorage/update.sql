update cc_enter_stock
set status=2,
	enter_date = {ts'${def:timestamp}'}
where tuid = ${fld:stocktuid}
and org_id = ${def:org}
