 select
 DISTINCT t.ptid,
 t.ptid,
 
  
 (
 case 
 	when t.pttype = 5  then  (select name from hr_staff where userlogin=
 									(select pt from cc_customer where code=${fld:customercode} and org_id = ${def:org} )
 								) 
 else
 	 (select name from hr_staff where userlogin=t.ptid) 
 end
 )as ptname
 
 
 
 from
 cc_ptrest t
 left join cc_ptdef p on t.ptlevelcode=p.code and p.org_id=t.org_id 
 where 
 t.customercode=${fld:customercode}
and t.org_id=${def:org}
