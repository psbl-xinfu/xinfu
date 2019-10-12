 select
 	concat('<label class="am-checkbox"><input type="checkbox"  data-am-ucheck name="datalist" code="',
 		c.status,
 		'" value="',
 		c.code,'',
 		'" code-cust="',c.customercode,'" code-relate="',COALESCE(c.relatecode,''),'" code-cttype="',c.contracttype,'" code-type="',c.type,'" ></label>') as application_id,
	(select groupname  from cc_cabinet 
	left join cc_cabinet_group on  cc_cabinet.groupid=cc_cabinet_group.tuid and cc_cabinet.org_id = cc_cabinet_group.org_id 
	where   cc_cabinet.cabinetcode= get_arr_value(c.relatedetail,1) and cc_cabinet.org_id = ${def:org}) as qu,

	c.code, --合同编号
 	m.name,
 	m.mobile,
 	 	(case
 	 	--租柜合同不需要审批 zzn 2019-03-28
 	 	--when c.type = 1 and c.status =1 and c.isaudit=1 then '未审批'
 	 	--when c.type = 1 and c.status =1 and c.isaudit=3 then '审批拒绝' 
 	when c.type = 1 and c.status = 1 then '未付款' when c.contracttype!=3 and c.status =2 and c.normalmoney=c.factmoney then  '已付款'
 when  c.contracttype!=3 and COALESCE(c.normalmoney, 0) = 
 COALESCE( (select (ct.factmoney+c.factmoney) from cc_contract ct 
		where ct.relatecode = c.code and ct.org_id = c.org_id and ct.status =2 ), 0)
 then '已还款'
 when c.contracttype!=3 and  COALESCE(c.normalmoney, 0) != COALESCE( (select (ct.factmoney+c.factmoney) from cc_contract ct 
		where ct.relatecode = c.code and ct.org_id = c.org_id and ct.status =2 ), 0)
then '未还款'
	when c.contracttype=3 and COALESCE(c.normalmoney, 0) != COALESCE(c.factmoney, 0) then '未付清'
	when c.contracttype=3 and COALESCE(c.normalmoney, 0) = COALESCE(c.factmoney, 0) then '已付清'
	
 	end)::varchar as i_status, --状态
 	(select cabinetcode from cc_cabinet where tuid::varchar =get_arr_value(c.relatedetail,1) and org_id = ${def:org}) as net_code,--柜子编号
 	round(factmoney::NUMERIC(10, 2), 2) as factmoney,
 	get_arr_value(c.relatedetail,3) as net_start,--柜子开始
 	get_arr_value(c.relatedetail,4) as net_end,--柜子截止
 	c.remark,--备注
 	c.createdby,--所属前台
 	(select name from hr_staff where userlogin=c.createdby) as createdby,--前台
	(SELECT name FROM hr_staff WHERE userlogin = c.salemember) AS salemember,--销售员
	(SELECT name FROM hr_staff WHERE userlogin = c.salemember1) AS salemember1,--销售员
 	(case 
 		when (c.status=2 and c.contracttype!=3 and c.normalmoney!=c.factmoney) then '定金' 
 		when (c.contracttype=3 and c.relatecode is not null and c.relatecode!='') then '还款' 
 		else '租柜' 
 	end) as contracttype
from cc_contract c 
left join cc_customer m on m.code= c.customercode  and m.org_id=${def:org}
where c.org_id=${def:org}
and
(
c.type=1
or
c.type=12
)

and
(
contracttype=0
or
contracttype=3
)
and c.status!=0
${filter} 
and (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else c.salemember = '${def:user}' or c.salemember1 = '${def:user}' end)
order by (case when c.updated is null then c.createdate else c.updated end) desc,c.createtime desc

