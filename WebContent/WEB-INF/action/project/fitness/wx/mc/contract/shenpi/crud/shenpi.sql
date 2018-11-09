 select
 		c.code,
		c.audittime,
		c.createdate,
		(select name from cc_cardtype where code =get_arr_value(c.relatedetail,3)     and org_id = ${def:org})as cardtype,
 		inimoney,
 		normalmoney,
 		isaudit,
 		customercode
from cc_contract c 
where

 c.org_id=${def:org}
and c.isaudit!=0
and c.salemember='${def:user}'
and 
(c.type = 5
or
c.type = 0
)
order by createdate desc,createtime desc



