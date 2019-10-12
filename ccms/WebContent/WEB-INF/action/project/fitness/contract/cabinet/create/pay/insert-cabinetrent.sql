INSERT INTO cc_cabinet_rent(
	tuid
	,customercode
	,cabinetid
	,cabinetcode
	,startdate
	,enddate
	,contractcode
	,is_deleted
	,createdby
	,created
	,org_id
) 
SELECT 
	nextval('seq_cc_cabinet_rent')
	,r.customercode
	,get_arr_value(r.relatedetail, 1)::integer	-- 储物柜id
	,(SELECT cabinetcode FROM cc_cabinet WHERE tuid = get_arr_value(r.relatedetail, 1)::integer AND org_id = ${def:org} LIMIT 1)	-- 储物柜code
	,(CASE WHEN get_arr_value(r.relatedetail, 3) = '' THEN NULL ELSE get_arr_value(r.relatedetail, 3) END)::date	-- 起租日期
	,(CASE WHEN get_arr_value(r.relatedetail, 4) = '' THEN NULL ELSE get_arr_value(r.relatedetail, 4) END)::date	-- 截止日期
	,r.code
	,0
	,'${def:user}'
	,{ts '${def:timestamp}'}
	,r.org_id  
FROM cc_contract r 
WHERE r.code = ${fld:contractcode} AND r.org_id = ${def:org}
