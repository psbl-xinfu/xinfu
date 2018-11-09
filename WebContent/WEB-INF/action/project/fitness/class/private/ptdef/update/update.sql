update cc_ptdef set 
  	ptlevelname= ${fld:ptlevelname},
  	reatetype= ${fld:reatetype},
  	ptfee= ${fld:ptfee},
  	scale= ${fld:scale},
  	status= ${fld:status},
  	is_delay= ${fld:is_delay},
	remark=${fld:remark},
	times=${fld:times},
	spacing=${fld:spacing}
where
	code=${fld:code} and org_id = ${def:org}
