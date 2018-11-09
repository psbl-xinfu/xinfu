 select
 	c.code, --合同编号
 	get_arr_value(c.relatedetail,11) as card_code,--卡号
 	m.name,
 	m.mobile,
 	(select cabinetcode from cc_cabinet where tuid = get_arr_value(c.relatedetail,1)::int and org_id = ${def:org}) as net_code,--柜子编号
 	factmoney,
 	get_arr_value(c.relatedetail,3) as net_start,--柜子开始
 	get_arr_value(c.relatedetail,4) as net_end,--柜子截止
 	c.remark,--备注
 	c.createdby,--所属前台
 	(select name from hr_staff where userlogin=c.createdby) as createdby,--前台
 	(select name from hr_staff where userlogin=c.salemember) as salemember--销售员
from cc_contract c 
left join cc_customer m on m.code= c.customercode  and m.org_id=${def:org}
where /** 普通会籍只能查看自己的会员合同 */
(case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else c.salemember = '${def:user}' end)
and c.org_id=${def:org} and m.code = ${fld:cust_code}
and (c.type=1 or c.type=12) and c.status = 2
and (contracttype=0 or contracttype=3)
order by indate desc


