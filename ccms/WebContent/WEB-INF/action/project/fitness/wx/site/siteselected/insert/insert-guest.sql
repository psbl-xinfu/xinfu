insert into cc_guest
(
	code,
	name,
	mobile,
	createdby,--
	created,--
	weixinlogin,
	org_id
)

(
	select 
		${seq:nextval@seq_cc_guest},
		${fld:customername},
		${fld:mobile},
		null,
		'${def:timestamp}',
		${fld:weixin_userid},
		${fld:org_id}
	from dual 
	where ${fld:customertype}='3'
)
