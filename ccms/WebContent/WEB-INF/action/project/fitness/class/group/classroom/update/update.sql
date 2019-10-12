update cc_classroom 
set 
	classroom_name=${fld:name},
	area=${fld:f_area},
	room_type=${fld:vc_type},
	limit_num=${fld:i_limit},
	ispreparedevice=${fld:vc_ispreparedevice},
	remark=${fld:vc_remark},
	status=${fld:status}  
where
	code = ${fld:vc_code} and org_id = ${def:org}
