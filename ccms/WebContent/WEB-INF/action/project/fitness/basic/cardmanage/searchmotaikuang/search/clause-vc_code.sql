and (
	cc_cardtype.code = ${fld:vc_code} 
	or cc_cardtype.name like '%'||${fld:vc_code}||'%'
)