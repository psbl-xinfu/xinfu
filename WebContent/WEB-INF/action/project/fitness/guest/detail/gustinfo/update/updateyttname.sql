update cc_thecontact set
  	status = (case when ${fld:ttname} is not null then (case when 
  		${fld:ttstatus} is not null then ${fld:ttstatus}
  		else (select status from cc_thecontact where code=${fld:yttcode} and org_id='${def:org}')
  	end)
  	else (select status from cc_thecontact where code=${fld:yttcode} and org_id='${def:org}')
  	end)
where
	code = ${fld:yttcode} and org_id='${def:org}'
	
	
	
	
	
	
