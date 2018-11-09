update cc_cabinet_rent
set deposit = (select (case when get_arr_value(relatedetail,10) = '' then '0.00' else get_arr_value(relatedetail,10) end)::numeric(10,2) 
			from cc_contract where code = cc_cabinet_rent.contractcode and org_id = ${def:org}),
	isdeposit = 1
where tuid = ${fld:tuid} and org_id = ${def:org}