and (
	c.code like concat('%', ${fld:pickcustname}, '%') or
	c.mobile like concat('%', ${fld:pickcustname}, '%') or c.name like concat('%', ${fld:pickcustname}, '%') 
	or exists(
		select 1 from cc_card d 
		where d.code like concat('%', ${fld:pickcustname}, '%') 
		and d.customercode = c.code and d.org_id = c.org_id 
		and d.isgoon = 0 
	)
	or exists(
		select 1 from cc_card d 
		where d.customercode = c.code and d.org_id = c.org_id 
		and d.isgoon = 0 
		and exists(
			select 1 from cc_cardcode cc
			where cc.cardcode = d.code and d.org_id = cc.org_id
			and cc.incode = ${fld:pickcustname}
		)
	)
) 

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