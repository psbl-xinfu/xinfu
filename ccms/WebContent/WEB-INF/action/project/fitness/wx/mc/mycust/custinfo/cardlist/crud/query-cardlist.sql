 select
	 d.startdate,	
	 d.enddate,
	 t.name as cardname,
	 (case when t.type =0 then '时效卡'  when t.type =1 then '记次卡'  when t.type =2 then '基金卡' else '体验卡' end ) as cardtype,
 	(select name from hr_staff where userlogin=c.salemember and org_id = ${def:org}) as salemember--销售员
from cc_contract c 
left join cc_card d on  d.contractcode=c.code   and isgoon=0 and d.status!=0 and d.status!=6 and d.org_id=${def:org}
left join cc_cardtype t on d.cardtype=t.code and t.org_id=${def:org}
where 
get_arr_value(c.relatedetail,0)=${fld:customercode}
and c.org_id=${def:org}
and (c.type=0 or c.type = 5) 
and
(
contracttype=0
or
contracttype=3
) 
and c.status != 0 

