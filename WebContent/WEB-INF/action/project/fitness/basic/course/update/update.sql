update cc_course set 
  courname= ${fld:vc_name},
  isgood=${fld:isgood}
where
 code= ${fld:vc_code} and org_id=${def:org}
