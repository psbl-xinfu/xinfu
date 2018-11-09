insert into cc_operatelog
(
	code,
	opertype,
	relatedetail,
	inimoney,
	normalmoney,
	factmoney,
	operationcode,
	status,
	createdby,
	createdate,
	createtime,
	org_id,
	customercode,
	pk_value
)
(
	select 
		${seq:nextval@seq_cc_operatelog},
		'29',
		concat('租柜退押金'),
		(select -(case when get_arr_value(relatedetail,10) = '' then '0.00' else get_arr_value(relatedetail,10) end)::numeric(10,2) 
			from cc_contract where code = (select contractcode from cc_cabinet_rent 
			where tuid::varchar = ${fld:id} and org_id = ${def:org}) and org_id = ${def:org}),
		(select -(case when get_arr_value(relatedetail,10) = '' then '0.00' else get_arr_value(relatedetail,10) end)::numeric(10,2)
			from cc_contract where code = (select contractcode from cc_cabinet_rent 
			where tuid::varchar = ${fld:id} and org_id = ${def:org}) and org_id = ${def:org}),
		(select -(case when get_arr_value(relatedetail,10) = '' then '0.00' else get_arr_value(relatedetail,10) end)::numeric(10,2) 
			from cc_contract where code = (select contractcode from cc_cabinet_rent 
			where tuid::varchar = ${fld:id} and org_id = ${def:org}) and org_id = ${def:org}),
		(select contractcode from cc_cabinet_rent 
			where tuid::varchar = ${fld:id} and org_id = ${def:org}),
		1,
		'${def:user}',
		'${def:date}',
		'${def:time}',
		${def:org},
		(select customercode from cc_cabinet_rent 
			where tuid::varchar = ${fld:id} and org_id = ${def:org}),
		(select tuid from cc_cabinet_rent 
			where tuid::varchar = ${fld:id} and org_id = ${def:org})
	from dual where ${fld:type}='1'
)
