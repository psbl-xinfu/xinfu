update cc_singleitemdef set
  fastcode= ${fld:vc_fastcode},
  name= ${fld:vc_name},
  type= ${fld:vc_type},
  unit= ${fld:vc_unit},
  price= ${fld:f_price},
  commission= ${fld:f_commission},
  isliliao=( case  when ${fld:i_isliliao}=1then 1  else 0 end),
  status= ${fld:i_status},
  remark= ${fld:vc_remark}
where
	code= ${fld:vc_code} and org_id = ${def:org}

