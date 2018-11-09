 select
 c.code,
(case when c.contracttype = 1 OR c.contracttype = 2  then '升级合同'
 		 when c.contracttype = 3 then '还款可同'
 		when	c.type = 5 then '定金合同'
 		when	c.type = 0 then '办卡合同'
 		when	c.type = 7 OR c.type = 9 OR c.type = 11 then '续卡合同'
 		when	c.type = 10	then '转卡合同'
 		when	c.type = 4	then '退卡合同'
 		when	c.type = 2	then '私教合同'
 		when	c.type = 1 OR c.type = 12  then '租柜合同'end) as type,
 c.createdate,
 get_arr_value(c.relatedetail,0)as customercode,
 factmoney,
 (select name from hr_staff where userlogin=c.salemember and org_id = ${def:org}) as salemember--销售员

 
from cc_contract c 
where 
get_arr_value(c.relatedetail,0)=${fld:customercode}
and c.org_id=${def:org}
and c.status != 0 
order by  c.createdate desc







