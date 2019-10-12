and 
(
case when ${fld:daochu_s_tong}=0  then
	exists (
			 (select  
			 	1
			 	from cc_cardcategory g 
			 	where g.code=c.cardcategory and union_id is not null and g.org_id=${def:org} and c.status=1 and g.status=1  limit 1)
		)
		else
	not exists (
			 (select  
			 	1
			 	from cc_cardcategory g 
			 	where g.code=c.cardcategory and union_id is not null and g.org_id=${def:org} and c.status=1 and g.status=1  limit 1)
		)
end
)

