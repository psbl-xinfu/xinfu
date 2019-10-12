UPDATE cc_card d 
SET 
	status = 0
	,remark = r.remark 
	,updatedby = '${def:user}'
	,updated = {ts '${def:timestamp}'}
FROM cc_contract r 
WHERE r.code = ${fld:contractcode}
AND d.code = get_arr_value(r.relatedetail, 1) 
AND d.contractcode = get_arr_value(r.relatedetail, 2) 
AND d.org_id = r.org_id AND d.org_id = ${def:org} 
