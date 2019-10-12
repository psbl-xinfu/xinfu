 select
DISTINCT t.ptlevelcode,
 p.ptlevelname,
 p.ptfee,
 t.ptlevelcode
 from
 cc_ptrest t
 left join cc_ptdef p on t.ptlevelcode=p.code and p.org_id=t.org_id 
 where 
 t.customercode=${fld:customercode}
and t.org_id=${def:org}
