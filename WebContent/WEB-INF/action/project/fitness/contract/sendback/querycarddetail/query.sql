select 
	d.code
	,d.isgoon
	,(case when d.isgoon = 1 then '【续卡】' else '' end) as isgoonname
	,d.cardtype 
	,t.name as cardtypename 
	,d.startdate
	,d.enddate
	,COALESCE(d.count,0) as count
	,COALESCE(d.nowcount,0) as nowcount
	,d.contractcode
	,COALESCE(r.inimoney,0.00) as inimoney
	,COALESCE(r.normalmoney,0.00) as normalmoney
	,(COALESCE(r.normalmoney,0.00) - COALESCE(r.factmoney,0.00) - COALESCE((
		select sum(COALESCE(r2.factmoney,0.00)) from cc_contract r2 
		where r2.relatecode = r.code and r2.org_id = r.org_id and r2.status >= 2
	),0.00)) as leftmoney 
	,COALESCE(c.moneyleft,0.00) as moneyleft 
	,({d '${def:date}'} - COALESCE(d.startdate, d.created::date)) as usedays 
from cc_card d 
left join cc_cardtype t on d.cardtype = t.code and d.org_id = t.org_id 
left join cc_contract r on r.code = d.contractcode and r.org_Id = d.org_id 
left join cc_customer c on c.code = d.customercode and c.org_id = d.org_id 
where d.code = ${fld:cardcode} and d.contractcode = ${fld:contractcode} 
and d.org_id = ${def:org} and d.status != 0 and d.status != 6 
