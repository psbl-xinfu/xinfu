UPDATE cc_cabinettemp
SET status = 1,
	cardcode=${fld:cardcode},
	customercode=${fld:cust_code},
	cardtype=${fld:cardtype},
	type=0,
	createdby='开发接口测试1',--createdby='${def:user}',临时使用固定
	created='${def:date}'
WHERE
	cabinettempcode = ${fld:rudge_code}
	and  ${fld:rudge_code} is not null and  ${fld:rudge_code} != '' 
	and org_id = ${fld:unionorgid}--and org_id = ${def:org}临时使用固定