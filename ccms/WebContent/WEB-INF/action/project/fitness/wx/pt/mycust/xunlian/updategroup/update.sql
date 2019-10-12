update cc_trainplan_detail_group
set num = ${fld:cc_num},
weight = ${fld:cc_weight},
custfeel = ${fld:cc_custfeel}
where 
code = ${fld:cc_code} 
and org_id = ${def:org}
