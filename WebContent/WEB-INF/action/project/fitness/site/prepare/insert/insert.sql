insert into cc_siteusedetail
(
	code,
	sitecode,--场地编号
	customertype,--客户类型：0资源、1会员、2团队、3散客
	guestgroupid,--团体编号
	customercode,--会员编号
	customername,--姓名
	mobile,--手机号码
	prepare_starttime,--预约开始时间
	prepare_endtime,--预约结束时间
	pretimes,--预订时长(分钟)
	prepare_date,--预约日期
	premoney,--预付款
	inimoney,--原价
	normalmoney,--应收
	factmoney,--实收
	status,--状态：0无效、1已预约、2已开场、3已离场、4已爽约
	paystatus,--付款状态：0未付款、1已付款
	prepare_type,--1包场2拼场
	createdby,--
	created,--
	org_id
)
values
(
	concat((select memberhead from hr_org where org_id = ${def:org}), ${seq:nextval@seq_cc_siteusedetail}),
	${fld:yydetialsitedef},
	(case when ${fld:bcorpc}='1' then 2 else ${fld:customertype} end),
	${fld:guestgroup},
	(case when ${fld:customertype}!='3' then ${fld:pkvalue} else ${seq:currval@seq_cc_guest}::varchar end),
	${fld:customername},
	${fld:mobile},
	${fld:yystarttime},
	${fld:yyendtime},
	(select to_char((${fld:yyendtime}::time-${fld:yystarttime}::time), 'HH24'))::integer*60,
	${fld:prepare_date},
	0,
	${fld:yyinputprice},
	${fld:yyinputprice},
	0,
	1,
	0,
	${fld:bcorpc},
	'${def:user}',
	'${def:timestamp}',
	${def:org}
)
