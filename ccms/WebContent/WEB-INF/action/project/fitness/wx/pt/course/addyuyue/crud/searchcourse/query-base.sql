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
and ptrest.pttotalcount>0

and  (case when  '${def:user}' = (select pt from cc_customer where code=${fld:customercode} and org_id=${def:org}  )
then (ptrest.ptlevelcode =( select df.code from cc_ptdef df where df.org_id=ptrest.org_id and df.reatetype=1) or ptrest.ptid='${def:user}')
else ptrest.ptid='${def:user}'
end ) 

