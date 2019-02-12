update e_cnfg set 
  vc_content= ${fld:rentunit}
where
	cnfg_id = ${fld:rentunit_id}
