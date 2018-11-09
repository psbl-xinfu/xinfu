SELECT ptdef.ptlevelname,ptrest.ptleftcount::int4,s.name as ptname
      ,
      (select comm.created from  cc_comm comm
       where comm.operatortype=1 and comm.customercode=${fld:customercode} 
        and comm.createdby=s.userlogin and comm.org_id=${def:org}
       order by comm.created desc 
      limit 1 ) as lasttime,
      ptrest.code,
      
 
 
 (
 case 
 	when ptrest.pttype = 5  then  (SELECT case when headpic is null then '/images/icon_head.png' else headpic end
		 FROM hr_staff WHERE userlogin =(select pt from cc_customer where code=${fld:customercode} and org_id = ${def:org} )
		 )
 else
 	    (SELECT 
			case when headpic is null then '/images/icon_head.png' else headpic end
		 FROM hr_staff WHERE userlogin =ptrest.ptid
		 )
 end
 )as headpic
		 
		 
		 
		 
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
 order by ptrest.created desc      