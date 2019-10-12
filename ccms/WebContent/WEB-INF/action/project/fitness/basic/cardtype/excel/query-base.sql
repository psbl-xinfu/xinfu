select
	c.code,
 	c.name,
 	f.cardfee,
 	(case when c.type=0 then '时效卡'  when c.type=1 then '计次卡' end) as type,
	 (select  
 	(case when 	g.union_id is null then '单店' else '通店'  end)
 	from cc_cardcategory g 
 	where g.code=c.cardcategory and g.org_id=${def:org} and c.status=1 and g.status=1 )as tongyong,
 	c.maxusernum,
 	(case when c.status=1 then '已启用' else '已禁用' end) as status
from cc_cardtype c
left join  cc_cardtype_fee  f on  c.code=f.cardtype and  f.org_id=${def:org}
where 1=1 
and c.org_id=${def:org} 
${filter}
order by c.code::integer desc