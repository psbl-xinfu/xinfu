select 
	t.code,
	t.warmup_mins,
	t.aerobic_mins,
	t.run_mileage,
	t.customercode as vc_customercode,
	t.ptid
from cc_trainplan t
where t.code = ${fld:code} and t.org_id = ${def:org}

