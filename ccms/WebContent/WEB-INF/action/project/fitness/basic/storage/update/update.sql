update cc_storage set 
	storage_name=${fld:storage_name},
	address=${fld:address},
	status=${fld:status}
where
	tuid = ${fld:tuid} and org_id = ${def:org}
