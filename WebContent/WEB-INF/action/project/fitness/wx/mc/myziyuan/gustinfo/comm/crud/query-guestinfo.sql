SELECT
name,
(case sex when '0' then '女' when '1' then '男'  else '未填' end) as sex,
mobile,
(select comm.created from  cc_comm comm
   where  comm.operatortype=0  and cust_type=0   and comm.guestcode=cc_guest.code and comm.createdby='${def:user}' 
   and comm.org_id = cc_guest.org_id order by comm.created desc limit 1 ) as lasttime
   
FROM cc_guest 
where code=${fld:guestcode}
and org_id=${def:org}