 AND
 (g.name LIKE '%'||${fld:vc_name}||'%'
 or
 g.mobile LIKE '%'||${fld:vc_name}||'%'
 or
 g.code LIKE '%'||${fld:vc_name}||'%'
 )