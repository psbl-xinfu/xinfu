select
	c.code
	,c.name
	,c.mobile 
	,c.org_id as homeunionorgid
from cc_customer c  
where ${fld:pickcustname} is not null and ${fld:pickcustname} != '' 
and (
	c.code like concat('%', ${fld:pickcustname}, '%') or
	c.mobile like concat('%', ${fld:pickcustname}, '%') or c.name like concat('%', ${fld:pickcustname}, '%') 
	or exists(
		select 1 from cc_card d 
		where d.code like concat('%', ${fld:pickcustname}, '%') 
		and d.customercode = c.code and d.org_id = c.org_id 
		and d.isgoon = 0 and d.status != 0 
	)
	or exists(
		select 1 from cc_card d 
		where d.customercode = c.code and d.org_id = c.org_id 
		and d.isgoon = 0 and d.status != 0 
		and d.code in (select cardcode from cc_cardcode where incode=${fld:pickcustname})
	)
) 
and c.status != 0 
and (
	c.org_id = ${def:org} or exists(
		select 1 from cc_card card
		inner join cc_cardtype ct on card.cardtype = ct.code and card.org_id = ct.org_id 
		inner join cc_cardcategory cate on ct.cardcategory = cate.code and ct.org_id = cate.org_id 
		inner join t_union u on cate.union_id = u.tuid 
		inner join t_union_club ub on u.tuid = ub.union_id 
		where card.customercode = c.code and card.org_id = c.org_id and ub.club_id = ${def:org} 
		and card.isgoon = 0 
	)
)

	