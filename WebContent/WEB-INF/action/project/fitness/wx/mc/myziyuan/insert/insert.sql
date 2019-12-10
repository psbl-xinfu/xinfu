insert into cc_guest
(
 	code
	,officename --公司名称
	,officetel  --电话
	,email 
	,officeaddr --地址
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
	
)
values 
(
	${seq:nextval@seq_cc_guest},
    ${fld:company},
	${fld:cc_officetel},
	${fld:cc_email},
	${fld:address},
	${fld:cc_remark},
	'${def:user}',
	'${def:user}',
	${fld:province2},
	${fld:city2},
	${fld:cc_birth},
	${fld:communication},
	${fld:custcation},
	'${def:user}',
	{ts '${def:timestamp}'},
	${def:org}
)


