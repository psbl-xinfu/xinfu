select 
	case when y.union_id is not null then (
		select string_agg(g.org_name,'&nbsp;&nbsp;&nbsp;') 
		from t_union u 
		inner join t_union_club uc on u.tuid = uc.union_id 
		inner join hr_org g on g.org_id = uc.club_id 
		where u.tuid = y.union_id
	) else (
		select g.org_name from hr_org g where g.org_id = ${def:org}
	) end as supportorgs 
from cc_cardtype e 
left join cc_cardcategory y on y.code = e.cardcategory and y.org_id = e.org_id 
where e.code = ${fld:cardtype} and e.org_id = ${def:org} 
