select 
	s.vc_code as vc_storage,
	s.vc_storage_name,
	(d.discount*100.00)::numeric(10,2) AS f_discount 
from e_storage s 
left join cc_cardtype_storage_discount d on d.storage = s.vc_code and d.cardtype = ${fld:in_vc_code} and s.vc_club = d.org_id
where s.vc_status = 0 
and s.vc_club = '${def:org}'
