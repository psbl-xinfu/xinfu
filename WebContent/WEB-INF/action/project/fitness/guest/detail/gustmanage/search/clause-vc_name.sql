 AND
 (tt.name LIKE '%'||${fld:vc_name}||'%'
 or
 tt.mobile LIKE '%'||${fld:vc_name}||'%'
  or
 g.officename LIKE '%'||${fld:vc_name}||'%'
 )