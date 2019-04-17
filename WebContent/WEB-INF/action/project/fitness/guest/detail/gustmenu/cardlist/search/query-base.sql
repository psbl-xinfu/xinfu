select
	get_arr_value(con.relatedetail,7) as cardtypename,
	--考虑续卡的情况 zzn 2019-04-10
	(case when card.isgoon=0
		then (case when card.status=0 then '无效'
			   when card.status=1 then '正常'
			   when card.status=2 then '未启用'
		           when card.status=3 then '存卡中'
		           when card.status=4 then '挂失中'
			   when card.status=5 then '停卡中'
			   when card.status=6 then '过期'
		end)
	      when card.isgoon=1  then '续卡未启用'
	      when card.isgoon=-1 then '续卡已过期'
	end)as status,
	card.code,
	cust.name,
	cust.mobile,
	con.normalmoney,
 	con.factmoney,
 	card.startdate,
	card.enddate,
	(select name from hr_staff where userlogin = card.createdby) as createdby,
	card.created
from cc_card card 
left join cc_customer cust on cust.code= card.customercode and card.org_id = cust.org_id
left join cc_contract con on card.contractcode = con.code and card.org_id = con.org_id
where /** 会籍顾问只能查看自己的数据 */
(case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else card.createdby = '${def:user}' end)
and card.org_id = ${def:org} and card.status = 1
and cust.code = ${fld:cust_code}

union

select
	get_arr_value(con.relatedetail,7) as cardtypename,
	(case when card.isgoon=0
		then (case when card.status=0 then '无效'
			   when card.status=1 then '正常'
			   when card.status=2 then '未启用'
		           when card.status=3 then '存卡中'
		           when card.status=4 then '挂失中'
			   when card.status=5 then '停卡中'
			   when card.status=6 then '过期'
		end)
	      when card.isgoon=1  then '续卡未启用'
	      when card.isgoon=-1 then '续卡已过期'
	end)as status,
	card.code,
	cust.name,
	cust.mobile,
	con.normalmoney,
 	con.factmoney,
 	card.startdate,
	card.enddate,
	(select name from hr_staff where userlogin = card.createdby) as createdby,
	card.created
from cc_card card 
left join cc_customer cust on cust.code= card.customercode and card.org_id = cust.org_id
left join cc_contract con on card.contractcode = con.code and card.org_id = con.org_id
where /** 会籍顾问只能查看自己的数据 */
(case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else card.createdby = '${def:user}' end)
and card.org_id = ${def:org} and card.status != 1
and cust.code = ${fld:cust_code}

order by created desc
