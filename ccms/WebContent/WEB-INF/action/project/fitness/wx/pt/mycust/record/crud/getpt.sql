SELECT
 (
 case 
 	when ptrest.pttype = 5  then  (select name from hr_staff where userlogin=
 									(select pt from cc_customer where code=${fld:customercode} and org_id = ${def:org} )
 								) 
 else
 	s.name
 end
 )as name,
 
  (
 case 
 	when ptrest.pttype = 5  then  (select userlogin from hr_staff where userlogin=
 									(select pt from cc_customer where code=${fld:customercode} and org_id = ${def:org} )
 								) 
 else
 	s.userlogin
 end
 )as userlogin


FROM cc_ptrest ptrest
    LEFT JOIN cc_ptdef ptdef ON ptdef.code=ptrest.ptlevelcode  and ptdef.org_id=${def:org}
    LEFT JOIN hr_staff s ON ptrest.ptid=s.userlogin
 WHERE ptrest.customercode=${fld:customercode} 
 and ptrest.org_id=${def:org} 
 and ptdef.status=1 
 and
 (
 ptrest.ptenddate>={d '${def:date}'}
 or
 ptrest.ptenddate is null
 )
