update cc_product set 
  proname= ${fld:vc_name},
  isgood=${fld:isgood}
where
 code= ${fld:vc_code} and org_id=${def:org}
