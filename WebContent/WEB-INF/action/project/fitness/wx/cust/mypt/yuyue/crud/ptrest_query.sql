SELECT ptdef.ptlevelname,ptrest.ptleftcount::int4, 
(select name from hr_staff where userlogin= (case when ptdef.reatetype=1 then 
      (select pt from cc_customer where code=ptrest.customercode and org_id=${def:org})
      else ptrest.ptid end)) as ptname
      ,
      (select comm.created from  cc_comm comm
       where comm.operatortype=1 and comm.customercode=${fld:customercode} 
        and comm.createdby= (select userlogin from hr_staff where userlogin= (case when ptdef.reatetype=1 then 
      (select pt from cc_customer where code=ptrest.customercode and org_id=${def:org})
      else ptrest.ptid end) and org_id=${def:org}) and comm.org_id=${def:org}
       order by comm.created desc 
      limit 1 ) as lasttime,
      (select userlogin from hr_staff where userlogin= (case when ptdef.reatetype=1 then 
      (select pt from cc_customer where code=ptrest.customercode and org_id=${def:org})
      else ptrest.ptid end)) as ptid,
      
       (SELECT 
			case when headpic is null then '/images/icon_head.png' else headpic end
		 FROM hr_staff WHERE userlogin =ptrest.ptid
		 )as headpic
 FROM cc_ptrest ptrest
    LEFT JOIN cc_ptdef ptdef ON ptdef.code=ptrest.ptlevelcode  and ptdef.org_id=${def:org}
 WHERE ptrest.customercode=${fld:customercode} 
 and ptrest.org_id=${def:org} and ptdef.status=1
 and ptrest.code=${fld:code}
 
