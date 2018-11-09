select
	code,
	(case 
		when c.contracttype = 1 OR c.contracttype = 2 then '升级合同'
		when c.contracttype = 3 then '还款合同'
		when c.contracttype = 5 then '定金合同'
		when type = 0   then '办卡合同'
		when c.type = 7 OR c.type = 9 OR c.type = 11 then '续卡合同'
		when c.type = 10 then '转卡合同'
		when c.type = 4 then '退卡合同'
		when c.type = 2 then '私教合同'
		when c.type = 1 OR c.type = 12 then '租柜合同'
	end) as contract_type,
	(case status when 1 then '未付款' when 2 then '已付款' end) as status,
	normalmoney,
	factmoney,
	(select name from hr_staff where userlogin = c.createdby) as createdby,
	concat(createdate, ' ', createtime) as createdate,
	remark,
	c.inimoney
from  cc_contract c
where 1=1 and customercode = ${fld:cust_code} and org_id = ${def:org}
and status =2
order by createdate desc, createtime desc
