update cc_cardtype set
  mealdiscount= ${fld:f_mealdiscount}/100.00,
  drinkdiscount= ${fld:f_drinkdiscount}/100.00,
  jsdiscount= ${fld:f_jsdiscount}/100.00,
  swimdiscount= ${fld:f_swimdiscount}/100.00,
  singlediscount= ${fld:f_singlediscount}/100.00,
  classdiscount= ${fld:f_classdiscount}/100.00 
where
 	code= ${fld:in_vc_code} and org_id = ${def:org}
