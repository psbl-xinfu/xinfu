insert into cc_guest
(
 	code
	,officename --公司名称
	,officetel  --电话
	,email 
	,officeaddr --地址
	,postcode --邮编
	,remark 
	,mc --顾问
	,initmc
	,province2 --省
	,city2  --市
	,customtype   --客户类型
	,communication --沟通阶段
	,custclass
	,createdby  --操作人
	,created  --操作时间
	,org_id
	,guestnum
)
values 
(
	${seq:nextval@seq_cc_guest},
    ${fld:company},
	${fld:cc_officetel},
	${fld:cc_email},
	${fld:address},
	${fld:postalcode},
	${fld:cc_remark},
	${fld:cc_mc},
	${fld:cc_mc},
	${fld:province2},
	${fld:city2},
	${fld:cc_birth},
	${fld:communication},
	${fld:custcation},
	'${def:user}',
	{ts '${def:timestamp}'},
	${def:org},
	(case when ${fld:guestnum}::int >1 then ${fld:guestnum} else 1 end)
)


