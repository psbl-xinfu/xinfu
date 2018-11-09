 and 
 exists(
  select 1 from cc_cabinet where cabinetcode= get_arr_value(c.relatedetail,1)  and cc_cabinet.org_id=${def:org}
  and status=${fld:s_status}
 )
