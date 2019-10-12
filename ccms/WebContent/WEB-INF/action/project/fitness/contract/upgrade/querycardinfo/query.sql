select
	d.code as cardcode
	,d.contractcode
	,t.normalmoney
	,d.cardtype
	,e.name as cardtypename
	,d.startdate
	,d.enddate
	,d.count
	,d.nowcount 
	,f.name as mcname 
	,d.starttype
	,(
		select n.domain_text_cn from t_domain n where n.namespace = 'StartType' and n.domain_value = d.starttype::varchar limit 1
	) as starttypename
	,case when y.union_id is not null then (
		select string_agg(g.org_name,'&nbsp;&nbsp;&nbsp;') 
		from t_union u 
		inner join t_union_club uc on u.tuid = uc.union_id 
		inner join hr_org g on g.org_id = uc.club_id 
		where u.tuid = y.union_id
	) else (
		select g.org_name from hr_org g where g.org_id = ${def:org}
	) end as supportorgs 
from cc_card d 
inner join cc_contract t on t.code = d.contractcode and t.org_id = d.org_id 
inner join cc_customer c on d.customercode = c.code and c.org_id = d.org_id 
left join hr_staff f on c.mc = f.userlogin 
inner join cc_cardtype e on e.code = d.cardtype and e.org_id = d.org_id 
left join cc_cardcategory y on y.code = e.cardcategory and y.org_id = e.org_id 
where d.code = ${fld:cardcode} and d.org_id = ${def:org} and d.isgoon = 0 
and d.status != 0 and d.status != 6 and t.status >= 2 
and t.normalmoney = COALESCE(t.factmoney,0.00) + COALESCE((
	select sum(COALESCE(t2.factmoney,0.00)) from cc_contract t2 
	where t2.relatecode = t.code and t2.org_id = t.org_id and t2.status >= 2
),0.00) 
and e.maxusernum = 1
