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
		'XG'||to_char({ts'${def:date}'},'yy')||lpad(${seq:nextval@seq_cc_guest}::varchar, 6, '0'),
		${fld:customername},
		${fld:mobile},
		null,
		'${def:timestamp}',
		${fld:weixin_userid},
		${fld:org_id}
	from dual 
	where ${fld:customertype}='3' and 
	(select count(mobile) from cc_guest where mobile=${fld:mobile} and org_id=${fld:org_id})=0
)
