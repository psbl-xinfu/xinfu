update cc_position set 
  posname= ${fld:vc_name}
where
 code= ${fld:vc_code} and org_id=${def:org}
