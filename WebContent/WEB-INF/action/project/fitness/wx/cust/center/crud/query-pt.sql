 select
 t.code,
 p.ptlevelname,
 t.ptleftcount,
 t.created,
 t.ptenddate,
 ptlevelcode,
 (case when t.ptenddate::date<'${def:date}'::date then '已过期' else '正常' end) as ptstatus,
 
 (
 case 
 	when t.pttype = 5  then  (select name from hr_staff where userlogin=
 									(select pt from cc_customer where code=${fld:customercode} and org_id = ${def:org} )
 								) 
 else
 	 (select name from hr_staff where userlogin=t.ptid and org_id = ${def:org}) 
 end
 )as pt
 
 from
 cc_ptrest t
 left join cc_ptdef p on t.ptlevelcode=p.code and p.org_id=${def:org}
 where 
 t.customercode=${fld:customercode}
and t.org_id=${def:org}
and t.ptleftcount>0
order by  status desc






