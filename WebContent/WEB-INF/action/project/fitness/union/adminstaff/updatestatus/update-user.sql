update ${schema}s_user  set 
  enabled = ${fld:status}
where user_id = ${fld:user_id}
