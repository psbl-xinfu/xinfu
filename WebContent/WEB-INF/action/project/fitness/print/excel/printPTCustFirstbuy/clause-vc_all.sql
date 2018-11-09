 AND (
	EXISTS(SELECT 1 FROM e_customer ct WHERE ct.vc_code = p.vc_customercode AND ct.vc_name LIKE '%'||${fld:vc_all}||'%' )
	OR p.vc_cardcode = ${fld:vc_all}
)