SELECT
ptrest.code,
ptdef.ptlevelname,
ptrest.ptleftcount::int4,
--s.name as ptname,
ptrest.ptid,
 
  (case when ptrest.ptenddate::date<'${def:date}'::date then '已过期' else '正常' end) as status

 FROM cc_ptrest ptrest
    INNER JOIN cc_ptdef ptdef ON ptdef.code=ptrest.ptlevelcode and ptrest.org_id = ptdef.org_id 
--    INNER JOIN hr_staff s ON ptrest.ptid=s.userlogin
 WHERE ptrest.customercode=${fld:customercode} 
 and ptrest.org_id=${def:org} 
 --and ptdef.status=1
and pttotalcount>0
and  ptrest.ptid='${def:user}'
