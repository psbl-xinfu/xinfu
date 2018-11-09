 select
 	get_arr_value(c.relatedetail,1) as net_code,--柜子编号
 	round(factmoney::NUMERIC(10, 2), 2) as factmoney,
 	get_arr_value(c.relatedetail,3) as net_start,--柜子开始
 	get_arr_value(c.relatedetail,4) as net_end--柜子截止
from cc_contract c 
left join cc_customer m on m.code= c.customercode  and m.org_id=${def:org} 
where
 c.org_id=${def:org}
  and m.code=${fld:customercode}
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
and c.status=2



