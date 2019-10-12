update e_cnfg set 
  vc_content= ${fld:unitprice}
where
	cnfg_id = ${fld:unitprice_id}
