select 
	t.*,
	ct.name as cardtype
from
(select
 	concat('<label class="am-checkbox"><input type="checkbox"  data-am-ucheck name="datalist" code="',
 		c.status,
 		'" value="',
 		c.code,'',
 		'" code-cust="',c.customercode,'" code-relate="',COALESCE(c.relatecode,''),'" code-cttype="',c.contracttype,'" code-type="',c.type,'" ></label>') as application_id,
 	c.code, --合同编号
 	get_arr_value(c.relatedetail,1) as card_code,--卡号
 	m.name,
 	m.mobile,
	(case when isaudit=1 then '未审批' when isaudit=3 then '审批拒绝' 
 	when c.status = 1 then '未付款' when c.status =2 then '已付款' end)::varchar as i_status, --状态
	get_arr_value(c.relatedetail, 14) as ctype,
 	get_arr_value(c.relatedetail,7) as ncardname,--现在卡名称
 	round(normalmoney::NUMERIC(10, 2), 2) as normalmoney,--应收
 	round(factmoney::NUMERIC(10, 2), 2) as factmoney,--实收
 	 c.collectdate as c_idate, --签约
 	(select enddate from cc_card where code=get_arr_value(c.relatedetail,1) and isgoon=0 and status=1  and org_id=${def:org}) as enddate,--截止
 	(select name from hr_staff where userlogin=c.salemember) as salemember,--销售员
 	(select name from hr_staff where userlogin=c.salemember1) as salemember1,--销售员
 	(select name from hr_staff where userlogin=c.createdby) as createdby,--录入人
 	c.org_id
from cc_contract c 
left join cc_customer m on m.code= c.customercode  and m.org_id=${def:org}
where c.org_id=${def:org}
and c.contracttype in (1,2)
and c.status!=0
${filter} 
and (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else c.salemember = '${def:user}' or c.salemember1 = '${def:user}' end)
order by (case when c.updated is null then c.createdate else c.updated end) desc,c.createtime desc
) as t
left join cc_cardtype ct on t.ctype = ct.code and t.org_id = ct.org_id


