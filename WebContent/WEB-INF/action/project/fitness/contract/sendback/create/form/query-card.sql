select 
	d.code
	,d.isgoon
	,(case when d.isgoon = 1 then '【续卡】' else '' end) as isgoonname
	,d.contractcode 
from cc_card d 
where d.customercode = ${fld:customercode} and d.org_id = ${def:org} 
and d.contractcode is not null and d.contractcode != '' 
and d.status != 0 and d.status != 6 
and (d.relatecode is null or d.relatecode='') --排除副卡
