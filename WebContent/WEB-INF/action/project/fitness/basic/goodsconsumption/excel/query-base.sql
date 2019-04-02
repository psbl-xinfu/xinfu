select 
	concat('<input type="radio" name="leavestocklist" value="', ls.tuid, '" code="', ls.paystatus,'" />') AS checklink,
	--tuid,
	cg.goods_name as tuid,--zzn 增加了商品名称
	cust.name as custname,
	cg.standard, --zzn 增加了商品规格
	cust.mobile,
	card.code as cardcode,
	ls.factmoney,
	ls.created,
	(select name from hr_staff where userlogin = ls.createdby and org_id = ${def:org}) as staff_name,
	(case when ls.paystatus=1 then '未付款' when ls.paystatus=2 then '已付款' end) as paystatus,
	(select sum(amount) from cc_leave_stock_goods where leave_stock_id = ls.tuid and org_id = ${def:org})::int as amount 
from cc_leave_stock ls
left join cc_customer cust on ls.customercode = cust.code and ls.org_id = cust.org_id
left join cc_card card on ls.paycardcode = card.code and card.isgoon = 0
left join cc_leave_stock_goods lg on ls.tuid = lg.leave_stock_id and lg.org_id = ls.org_id --zzn 
left join cc_goods cg on cg.tuid= lg.goodsid and  card.org_id = ls.org_id  --zzn
where ls.org_id = ${def:org} and ls.status=2
--zzn 2019-03-27 and (case when (select data_limit from hr_staff where userlogin = '${def:user}' and org_id = ${def:org})=1 then 1=1 else ls.createdby = '${def:user}' end)
and (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else ls.createdby = '${def:user}' end)

${filter}
order by ls.created desc


