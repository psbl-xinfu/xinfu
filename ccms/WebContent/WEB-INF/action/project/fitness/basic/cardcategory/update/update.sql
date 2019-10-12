update cc_cardcategory set 
  category_name= ${fld:vc_name},
  showorder= ${fld:i_priority},
  remark= ${fld:vc_remark},
  union_id = ${fld:union_id} 
where
 code= ${fld:vc_code}
