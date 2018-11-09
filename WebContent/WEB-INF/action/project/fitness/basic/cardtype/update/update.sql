update cc_cardtype set 
  name= ${fld:vc_name},
  count = ${fld:count},
  daycount = ${fld:daycount},
  type= ${fld:vc_cardcategory},
  cardcategory= ${fld:vc_type},
  bgcolor = ${fld:vc_color},
  giveday= ${fld:vc_giveday},
  ptcount= ${fld:vc_ptcount},
  maxusernum=${fld:vc_maxusernum},
  scale=${fld:vc_scale}/100.0,
     
  mealdiscount= (case when ${fld:vc_mealdiscount} is null then 0 else ${fld:vc_mealdiscount}/100.0 end),
  drinkdiscount= (case when ${fld:vc_drinkdiscount} is null then 0 else ${fld:vc_drinkdiscount}/100.0 end),
  jsdiscount= (case when ${fld:vc_jsdiscount} is null then 0 else ${fld:vc_jsdiscount}/100.0 end),
  swimdiscount= (case when ${fld:vc_swimdiscount} is null then 0 else ${fld:vc_swimdiscount}/100.0 end),
  singlediscount= (case when ${fld:vc_singlediscount} is null then 0 else ${fld:vc_singlediscount}/100.0 end),
  classdiscount= (case when ${fld:vc_classdiscount} is null then 0 else ${fld:vc_singlediscount}/100.0 end),
  scaletype = ${fld:scaletype},
  remark=${fld:vc_remark},
  opencarddeadline = ${fld:opencarddeadline}
where
 code= ${fld:vc_code} and org_id=${def:org}
