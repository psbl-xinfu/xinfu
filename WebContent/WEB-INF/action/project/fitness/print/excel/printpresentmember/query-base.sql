select 
	cl.cardcode as vc_cardcode,	
	(case when cl.cabinettempcode is null then '' else cl.cabinettempcode end) as vc_cabinettempcode,
	cust.name as vc_name, 
	cust.code as bianhao, 
	staff.name AS vc_inusername,
	ct.name as vc_type,	
	cl.intime as c_initime,	
	cl.remark as vc_remark
from (
	select	
		max(replace(inleft.code,COALESCE((SELECT memberhead FROM hr_org WHERE org_id = ${def:org}),''),'')::bigint) as max_code,
		inleft.cardcode 
	from cc_inleft inleft 
	left join cc_cabinettemp cab on cab.tuid::varchar=inleft.cabinettempcode and inleft.org_id = cab.org_id
	where 1=1 
	and inleft.indate='${def:date}' 
	and inleft.lefttime is null
	${filter} 
	AND inleft.org_id = ${def:org}
	GROUP BY inleft.cardcode
) as t 
inner join cc_inleft cl on t.max_code = replace(cl.code,COALESCE((SELECT memberhead FROM hr_org WHERE org_id = ${def:org}),''),'')::bigint  
left join cc_card card on card.code=cl.cardcode and card.isgoon = 0 and cl.org_id = card.org_id 
left join cc_cardtype ct on card.cardtype = ct.code and ct.org_id = card.org_id 
left join cc_customer cust on card.customercode = cust.code and cust.org_id = card.org_id 
left join hr_staff staff on staff.userlogin=cl.inuser and cl.org_id = staff.org_id 
where cl.org_id = ${def:org}
