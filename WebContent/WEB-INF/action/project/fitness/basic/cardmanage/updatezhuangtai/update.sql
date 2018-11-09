update cc_cardtype set
	status=(case status when 1 then 0 else 1 end)
where 
  	code=${fld:vc_code} and org_id = ${def:org}
 
 
 
 
