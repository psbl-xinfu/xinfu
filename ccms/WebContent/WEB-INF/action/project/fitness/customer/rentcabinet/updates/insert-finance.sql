insert into cc_finance
(
	code,--主键
	customercode,--客户编号
	operatelogcode,
	operationcode,
	type,
	item,
	detail,
	premoney,
	money,
	moneyleft,
	status,
	createdby,
	created,
	org_id
)
(
	select 
		${seq:nextval@seq_cc_finance},	--主键
		(select customercode from cc_cabinet_rent 
			where tuid::varchar = ${fld:id} and org_id = ${def:org}),
		${seq:currval@seq_cc_operatelog},
		(select contractcode from cc_cabinet_rent 
				where tuid::varchar = ${fld:id} and org_id = ${def:org}),
		3,
		31,
		'租柜退押金',
		(select -(case when get_arr_value(relatedetail,10) = '' then '0.00' else get_arr_value(relatedetail,10) end)::numeric(10,2) 
			from cc_contract where code = (select contractcode from cc_cabinet_rent 
			where tuid::varchar = ${fld:id} and org_id = ${def:org}) and org_id = ${def:org}),
		(select -(case when get_arr_value(relatedetail,10) = '' then '0.00' else get_arr_value(relatedetail,10) end)::numeric(10,2) 
			from cc_contract where code = (select contractcode from cc_cabinet_rent 
			where tuid::varchar = ${fld:id} and org_id = ${def:org}) and org_id = ${def:org}),
		0,
		1,
		'${def:user}',--操作人
		{ts'${def:timestamp}'},
		${def:org}
	from dual where ${fld:type}='1'
)


