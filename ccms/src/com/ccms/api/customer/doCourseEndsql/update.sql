--修改上过课的记录给个下课时间
UPDATE cc_ptlog 
SET 
	quittingtime = '${def:timestamp}'
WHERE code = ${fld:ptlogcode} and org_id = ${fld:org}
