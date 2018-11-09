delete from cc_cardtype_storage_discount d where d.cardtype = ${fld:in_vc_code} and d.org_id = ${def:org}
and exists (
	select 1 from e_storage s where d.storage = s.vc_code 
	and s.vc_status = 0 and s.vc_club = '${def:org}'
)

