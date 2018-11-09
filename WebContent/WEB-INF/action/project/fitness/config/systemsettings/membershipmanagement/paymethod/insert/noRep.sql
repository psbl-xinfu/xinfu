select 1 from cc_config where param_text = ${fld:vc_content} and category = ${fld:category}
and (case when 
	exists (select 1 from cc_config where org_id = ${def:org} and category = ${fld:category})
	then org_id = ${def:org} else 1=1 end)