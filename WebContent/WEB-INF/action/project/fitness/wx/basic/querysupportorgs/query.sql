select 
	concat((select string_agg(b.group_name,'&nbsp;&nbsp;&nbsp;')
		from t_union_club t
		left join t_union b on t.club_id=b.tuid
		where t.union_id::varchar = y.union_id::varchar
		),'  ',
		(select string_agg(g.org_name,'&nbsp;&nbsp;&nbsp;') from hr_org g where g.org_id = ${def:org})) as supportorgs
from cc_cardtype e 
left join cc_cardcategory y on y.code = e.cardcategory and y.org_id = e.org_id 
where e.code = ${fld:cardtype} and e.org_id = ${def:org} 



