insert into cc_guest
(
 	code
	,officename --公司名称
	,othertel  --电话
	,email 
	--,officeaddr --地址
	--,postcode --邮编
	,remark  --公司备注
	,mc --顾问
	,initmc
	,province2 --省
	,city2  --市
	,customtype   --公司类型
	,communication --客户分类
	,custclass  --客户详细分类
	,createdby  --操作人
	,created  --操作时间
	,org_id
	,guestnum --公司数量
	,thepublic --公众号
	,channel --获客渠道
	,possibility
)
values 
(
	${seq:nextval@seq_cc_guest},
    ${fld:company},
	${fld:cc_officetel},
	${fld:cc_email},
	--${fld:address},
	--${fld:postalcode},
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
	${fld:guestnum},
	${fld:thepublic},
	${fld:cc_channel},
	${fld:possibility4}
	
)


