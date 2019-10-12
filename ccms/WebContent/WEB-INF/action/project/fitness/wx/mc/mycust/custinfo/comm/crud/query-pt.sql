 select
 c.code
from cc_contract c 
inner join cc_customer m on m.code= c.customercode  and m.org_id=${def:org} and m.code=${fld:customercode}
left join cc_ptrest p on p.contractcode= c.code  and p.org_id=${def:org}
and c.org_id=${def:org}
and c.type =2
and
(
contracttype=0
or
contracttype=3
)
and c.status!=0



