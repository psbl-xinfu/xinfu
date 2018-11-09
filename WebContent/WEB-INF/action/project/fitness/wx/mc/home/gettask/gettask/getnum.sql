(select count(*) as guest_daynum,  3 as num from  cc_comm where createdby='${def:user}' and  to_char(created, 'YYYY-MM') =to_char(now(), 'YYYY-MM') and org_id = ${def:org})
union all
(select   COALESCE(sum(factmoney),0)  as guest_daynum,  11 as num from  cc_contract where salemember='${def:user}'and  to_char(createdate, 'YYYY-MM') =to_char(now(), 'YYYY-MM' )and status=2 and org_id = ${def:org})

