 AND
 (the.name LIKE '%'||${fld:vc_name}||'%'
 or
 the.mobile LIKE '%'||${fld:vc_name}||'%'
  or
 the.mobile2 LIKE '%'||${fld:vc_name}||'%'
 )