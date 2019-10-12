insert into cc_singleitemdef
(
   code,
   fastcode,
   name,
   type,
   unit,
   price,
   commission,
   remark,
   status,
   isliliao,
   org_id
)
values 
(
	${seq:nextval@seq_cc_singleitemdef},
     ${fld:vc_fastcode},
    ${fld:vc_name},
    ${fld:vc_type},
    ${fld:vc_unit},
    ${fld:f_price},
    ${fld:f_commission},
     ${fld:vc_remark},
  	${fld:i_status},
    case  when ${fld:i_isliliao}=1then 1  else 0 end,
    ${def:org}
)
