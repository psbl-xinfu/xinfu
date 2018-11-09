insert into ws_sale_order
(
	sale_order_id,
	sale_order_code,
	sale_order_date,
	state,
	detail,
	org_id,
	pay_method,
	total_price,
	created,
	createdby
)
values
(
	${seq:nextval@seq_ws_sale_order},
	concat((select memberhead from hr_org where org_id = ${fld:org_id}), ${seq:currval@seq_cc_siteusedetail}),
	'${def:timestamp}',
	20,
	concat((select sitename from cc_sitedef where code = ${fld:yydetialsitedef} and org_id = ${fld:org_id}),
		'，预约日期',${fld:prepare_date},' ',to_char(${fld:yystarttime}::time, 'hh24:mi'),'~',to_char(${fld:yyendtime}::time, 'hh24:mi')
	),
	${fld:org_id},
	3,
	${fld:yyinputprice},
	'${def:timestamp}',
	(select userlogin from hr_staff where weixin_lastlogin = ${fld:weixin_userid})
)
