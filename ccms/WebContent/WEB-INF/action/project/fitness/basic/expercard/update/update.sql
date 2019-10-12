update cc_expercard set 
  name= ${fld:c_cardname},
  contact_phone= ${fld:c_contact_phone},
  address= ${fld:c_address},
  expertype= ${fld:c_expertype},
  
  experlimit= ${fld:c_experlimit},
  validatetype= ${fld:c_validatetype},
  enddate= (case when ${fld:c_validatetype}=1 and ${fld:c_enddate} is null 
  	then (select startdate from cc_market_campaign where code = ${fld:m_code} and org_id = ${def:org} ) else ${fld:c_enddate} end),
  startdate= (case when ${fld:c_validatetype}=1 and ${fld:c_startdate} is null 
  	then (select startdate from cc_market_campaign where code = ${fld:m_code} and org_id = ${def:org} ) else ${fld:c_startdate} end),
  useremark= ${fld:c_useremark},
  createdby='${def:user}',
  created= {ts'${def:timestamp}'},
  org_name=${fld:c_name}
where
  code = ${fld:c_code};
