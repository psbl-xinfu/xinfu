update cc_expercard set 
  name= ${fld:c_cardname},
  covertype= ${fld:c_covertype},
  covervalue= ${fld:c_covervalue},
  descr= ${fld:c_descr},
  contact_phone= ${fld:c_contact_phone},
  address= ${fld:c_address},
  expertype= ${fld:c_expertype},
  
  experlimit= ${fld:c_experlimit},
  validatetype= ${fld:c_validatetype},
  enddate= ${fld:c_enddate},
  startdate= ${fld:c_startdate},
  
  isneddmobile= ${fld:c_isneddmobile},
  useremark= ${fld:c_useremark},
  createdby='${def:user}',
  created= {ts'${def:timestamp}'}
where
  code = ${fld:c_code};
