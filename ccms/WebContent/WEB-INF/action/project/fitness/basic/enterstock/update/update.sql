update cc_enter_stock set 
	storageid=${fld:storageid},
	remark=${fld:remark}
where
	tuid = ${fld:tuid} and org_id = ${def:org}
