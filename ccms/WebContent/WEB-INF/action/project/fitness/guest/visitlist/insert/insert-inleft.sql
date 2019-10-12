insert into cc_inleft
(   
    code,--编号
	guestcode,--会员编号：表cc_guest主键
	intime,--入场时间
	inuser,--入场操作人
	indate,--入场日期
	itemtype,--健身
	bringother,--带朋友入场
    org_id--俱乐部编号
)
values
(
	${seq:nextval@seq_cc_inleft},
	(case when ${fld:guest_code} is null then 
	'XG'||to_char({ts'${def:date}'},'yy')||lpad(${seq:currval@seq_cc_guest}::varchar, 6, '0')
	else ${fld:guest_code} end),
	{ts'${def:timestamp}'},
	'${def:user}',
	'${def:date}',
	0,
	0,
	${def:org}
)

