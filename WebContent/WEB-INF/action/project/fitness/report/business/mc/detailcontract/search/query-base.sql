select 
	c.code,
 	get_arr_value(c.relatedetail,1) as card_code,
 	cust.name,
 	cust.mobile,
 	round(normalmoney::NUMERIC(10, 2), 2) as normalmoney,--应收金额
 	round(factmoney::NUMERIC(10, 2), 2) as factmoney,--实收金额
 	c.collectdate, --签约时间
 	'' as cardname,
 	'' as ncardname,
 	'' as net_code, 
 	'' as net_start,
 	'' as net_end,
	'' as ptlevelname,
	'' as pt,
	'' as pttotalcount,
	'' as ptenddate
from cc_contract c 
left join cc_customer cust on c.customercode = cust.code and c.org_id = cust.org_id
where c.createdate >= ${fld:startdate} and c.createdate <= ${fld:enddate} 
and c.org_id=${def:org} and c.status>=2 and (c.contracttype = 0 or c.contracttype = 1 or c.contracttype = 3) and (c.type=0 or c.type=5) 
and exists(
	select 1 from hr_skill k 
	inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
	where k.skill_scope = '2' and fk.userlogin = c.salemember 
) and ${fld:type}='1'
and c.salemember=(case when ${fld:userlogin} is null then c.salemember else ${fld:userlogin} end )

union 

select 
	c.code,
 	get_arr_value(c.relatedetail,1) as card_code,
 	cust.name,
 	cust.mobile,
 	round(normalmoney::NUMERIC(10, 2), 2) as normalmoney,--应收金额
 	round(factmoney::NUMERIC(10, 2), 2) as factmoney,--实收金额
 	c.collectdate, --签约时间
 	'' as cardname,
 	'' as ncardname,
 	'' as net_code, 
 	'' as net_start,
 	'' as net_end,
	'' as ptlevelname,
	'' as pt,
	'' as pttotalcount,
	'' as ptenddate
from cc_contract c 
left join cc_customer cust on c.customercode = cust.code and c.org_id = cust.org_id
where c.createdate >= ${fld:startdate} and c.createdate <= ${fld:enddate} 
and c.org_id=${def:org} and c.status>=2 and (c.contracttype = 0 or c.contracttype = 1 or c.contracttype = 3) and (c.type=0 or c.type=5) and exists(
	select 1 from hr_skill k 
	inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
	where k.skill_scope = '2' and fk.userlogin = c.salemember1 
)
and c.salemember1=(case when ${fld:userlogin} is null then c.salemember1 else ${fld:userlogin} end )
and c.salemember1 is not null and ${fld:type}='1'

union

select 
	c.code,
 	get_arr_value(c.relatedetail,1) as card_code,
 	cust.name,
 	cust.mobile,
 	round(normalmoney::NUMERIC(10, 2), 2) as normalmoney,--应收金额
 	round(factmoney::NUMERIC(10, 2), 2) as factmoney,--实收金额
 	c.collectdate, --签约时间
 	(select name from cc_cardtype as ct
 	where ct.code=get_arr_value(c.relatedetail,2) and ct.org_id=${def:org}) as cardname, --原卡名
 	get_arr_value(c.relatedetail,7) as ncardname,--新卡名称 
 	'' as net_code, 
 	'' as net_start,
 	'' as net_end,
	'' as ptlevelname,
	'' as pt,
	'' as pttotalcount,
	'' as ptenddate
from cc_contract c 
left join cc_customer cust on c.customercode = cust.code and c.org_id = cust.org_id
where c.createdate >= ${fld:startdate} and c.createdate <= ${fld:enddate} 
and c.org_id=${def:org} and c.status>=2 and(c.type=7 or c.type=9 or c.type=11) and (c.contracttype = 0 or c.contracttype = 1 or c.contracttype = 3)
and exists(
	select 1 from hr_skill k 
	inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
	where k.skill_scope = '2' and fk.userlogin = c.salemember 
) and ${fld:type}='2'
and c.salemember=(case when ${fld:userlogin} is null then c.salemember else ${fld:userlogin} end )


union 

select 
	c.code,
 	get_arr_value(c.relatedetail,1) as card_code,
 	cust.name,
 	cust.mobile,
 	round(normalmoney::NUMERIC(10, 2), 2) as normalmoney,--应收金额
 	round(factmoney::NUMERIC(10, 2), 2) as factmoney,--实收金额
 	c.collectdate, --签约时间
 	(select name from cc_cardtype as ct
 	where ct.code=get_arr_value(c.relatedetail,2) and ct.org_id=${def:org}) as cardname, --原卡名
 	get_arr_value(c.relatedetail,7) as ncardname,--新卡名称
 	'' as net_code, 
 	'' as net_start,
 	'' as net_end,
	'' as ptlevelname,
	'' as pt,
	'' as pttotalcount,
	'' as ptenddate
from cc_contract c 
left join cc_customer cust on c.customercode = cust.code and c.org_id = cust.org_id
where c.createdate >= ${fld:startdate} and c.createdate <= ${fld:enddate} 
and c.org_id=${def:org} and c.status>=2 and(c.type=7 or c.type=9 or c.type=11)
and (c.contracttype = 0 or c.contracttype = 1 or c.contracttype = 3)
and exists(
	select 1 from hr_skill k 
	inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
	where k.skill_scope = '2' and fk.userlogin = c.salemember1 
)
and c.salemember1=(case when  ${fld:userlogin} is null then c.salemember1 else ${fld:userlogin} end )
and c.salemember1 is not null and ${fld:type}='2'

union

select 
	c.code,
 	'' as card_code,
 	cust.name,
 	cust.mobile,
 	round(normalmoney::NUMERIC(10, 2), 2) as normalmoney,--应收金额
 	round(factmoney::NUMERIC(10, 2), 2) as factmoney,--实收金额
 	c.collectdate, --签约时间
 	'' as cardname, --原卡名
 	'' as ncardname,--新卡名称
 	'' as net_code, 
 	'' as net_start,
 	'' as net_end,
 	(SELECT d.ptlevelname FROM cc_ptdef d 
		WHERE d.code = get_arr_value(c.relatedetail, 1) AND d.org_id = ${def:org}) as ptlevelname,--课程名
	(SELECT name FROM hr_staff WHERE userlogin =  get_arr_value(c.relatedetail, 8) AND org_id = ${def:org}) AS pt,--课程教练
	get_arr_value(c.relatedetail, 2) AS pttotalcount,--总节数
	 get_arr_value(c.relatedetail, 3) AS ptenddate--截止日期
from cc_contract c 
left join cc_customer cust on c.customercode = cust.code and c.org_id = cust.org_id
where c.createdate >= ${fld:startdate} and c.createdate <= ${fld:enddate} 
and c.org_id=${def:org} and c.status>=2 and c.contracttype = 0 and c.type=2 
and exists(
	select 1 from hr_skill k 
	inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
	where k.skill_scope = '2' and fk.userlogin = c.salemember 
) and ${fld:type}='3'
and c.salemember=(case when ${fld:userlogin} is null then c.salemember else ${fld:userlogin} end )

union 

select 
	c.code,
 	'' as card_code,
 	cust.name,
 	cust.mobile,
 	round(normalmoney::NUMERIC(10, 2), 2) as normalmoney,--应收金额
 	round(factmoney::NUMERIC(10, 2), 2) as factmoney,--实收金额
 	c.collectdate, --签约时间
 	'' as cardname, --原卡名
 	'' as ncardname,--新卡名称
 	'' as net_code, 
 	'' as net_start,
 	'' as net_end,
 	(SELECT d.ptlevelname FROM cc_ptdef d 
		WHERE d.code = get_arr_value(c.relatedetail, 1) AND d.org_id = ${def:org}) as ptlevelname,--课程名
	(SELECT name FROM hr_staff WHERE userlogin =  get_arr_value(c.relatedetail, 8) AND org_id = ${def:org}) AS pt,--课程教练
	get_arr_value(c.relatedetail, 2) AS pttotalcount,--总节数
	 get_arr_value(c.relatedetail, 3) AS ptenddate--截止日期
from cc_contract c 
left join cc_customer cust on c.customercode = cust.code and c.org_id = cust.org_id
where c.createdate >= ${fld:startdate} and c.createdate <= ${fld:enddate} 
and c.org_id=${def:org} and c.status>=2 and c.contracttype = 0 and c.type=2  and exists(
	select 1 from hr_skill k 
	inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
	where k.skill_scope = '2' and fk.userlogin = c.salemember1 
)
and c.salemember1=(case when ${fld:userlogin} is null then c.salemember1 else ${fld:userlogin} end )
and c.salemember1 is not null and ${fld:type}='3'

union

select 
	c.code,
 	'' as card_code,
 	cust.name,
 	cust.mobile,
 	round(normalmoney::NUMERIC(10, 2), 2) as normalmoney,--应收金额
 	round(factmoney::NUMERIC(10, 2), 2) as factmoney,--实收金额
 	c.collectdate, --签约时间
 	'' as cardname,
 	'' as ncardname,
 	(select cabinetcode from cc_cabinet where tuid::varchar =get_arr_value(c.relatedetail,1) and org_id = ${def:org}) as net_code,--柜子编号
 	get_arr_value(c.relatedetail,3) as net_start,--柜子开始
 	get_arr_value(c.relatedetail,4) as net_end,--柜子截止
	'' as ptlevelname,
	'' as pt,
	'' as pttotalcount,
	'' as ptenddate
from cc_contract c 
left join cc_customer cust on c.customercode = cust.code and c.org_id = cust.org_id
where c.createdate >= ${fld:startdate} and c.createdate <= ${fld:enddate} 
and c.org_id=${def:org} and c.status>=2 and (c.type=1 or  c.type=12)
and exists(
	select 1 from hr_skill k 
	inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
	where k.skill_scope = '2' and fk.userlogin = c.salemember 
) and ${fld:type}='4'
and c.salemember=(case when ${fld:userlogin} is null then c.salemember else ${fld:userlogin} end )

union 

select 
	c.code,
 	'' as card_code,
 	cust.name,
 	cust.mobile,
 	round(normalmoney::NUMERIC(10, 2), 2) as normalmoney,--应收金额
 	round(factmoney::NUMERIC(10, 2), 2) as factmoney,--实收金额
 	c.collectdate, --签约时间
 	'' as cardname,
 	'' as ncardname,
 	(select cabinetcode from cc_cabinet where tuid::varchar =get_arr_value(c.relatedetail,1) and org_id = ${def:org}) as net_code,--柜子编号
 	get_arr_value(c.relatedetail,3) as net_start,--柜子开始
 	get_arr_value(c.relatedetail,4) as net_end,--柜子截止
	'' as ptlevelname,
	'' as pt,
	'' as pttotalcount,
	'' as ptenddate
from cc_contract c 
left join cc_customer cust on c.customercode = cust.code and c.org_id = cust.org_id
where c.createdate >= ${fld:startdate} and c.createdate <= ${fld:enddate} 
and c.org_id=${def:org} and c.status>=2 and (c.type=1 or  c.type=12) and exists(
	select 1 from hr_skill k 
	inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
	where k.skill_scope = '2' and fk.userlogin = c.salemember1 
)
and c.salemember1=(case when ${fld:userlogin} is null then c.salemember1 else ${fld:userlogin} end )
and c.salemember1 is not null and ${fld:type}='4'

 
order by collectdate desc