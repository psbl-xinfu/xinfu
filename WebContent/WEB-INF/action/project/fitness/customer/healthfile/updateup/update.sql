update cc_customer set 
    code=${fld:vc_code},
    status=${fld:i_status},
    name=${fld:vc_name},
    sex=${fld:i_sex},
    org_id=${fld:vc_club},
    birthdate=${fld:c_birthdate}
where
  	code=${fld:vc_code} and org_id = ${def:org}
