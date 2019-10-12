update cc_cabinet_rent
set isdeposit = 1,
	deposit = (select (case when get_arr_value(relatedetail,10) = '' then '0.00' else get_arr_value(relatedetail,10) end)::numeric(10,2)
		from cc_contract where code = cc_cabinet_rent.contractcode and org_id = ${def:org})
where tuid::varchar = ${fld:id}
and ${fld:type}='1' and org_id = ${def:org}
