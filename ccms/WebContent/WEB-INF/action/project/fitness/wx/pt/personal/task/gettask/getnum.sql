(select count(*) as guest_daynum,  0 as num from  cc_comm where createdby='${def:user}' and created::date=${fld:s_date}::date and org_id = ${def:org})
union all
(select count(*) as guest_daynum,  1 as num from  cc_comm where createdby='${def:user}'and  to_char(created, 'YYYY-MM') =to_char(${fld:s_date}, 'YYYY-MM') and org_id = ${def:org})
union all



(select count(*) as guest_daynum,  2 as num from  cc_siteusedetail where openuser='${def:user}' and opentime::date=${fld:s_date}::date  and status!=0 and org_id=${def:org})
union all
(select count(*) as guest_daynum,  3 as num from  cc_siteusedetail where openuser='${def:user}'and  to_char(opentime, 'YYYY-MM') =to_char(${fld:s_date}, 'YYYY-MM') and status!=0 and org_id=${def:org})
union all--场开

(select count(*) as guest_daynum,  4 as num from  cc_testresult where createdby='${def:user}' and created::date=${fld:s_date}::date and status=1 and org_id=${def:org})
union all
(select count(*) as guest_daynum,  5 as num from  cc_testresult where createdby='${def:user}'and  to_char(created, 'YYYY-MM') =to_char(${fld:s_date}, 'YYYY-MM') and status=1 and org_id=${def:org})
union all--体测量

(select count(*) as guest_daynum,  6 as num from  cc_ptrest where ptid='${def:user}' and created::date=${fld:s_date}::date and pttype=5	and org_id=${def:org})
union all
(select count(*) as guest_daynum,  7 as num from  cc_ptrest where ptid='${def:user}'and  to_char(created, 'YYYY-MM') =to_char(${fld:s_date}, 'YYYY-MM') and pttype=5 and org_id=${def:org})
union all--体验课数

(select count(*) as guest_daynum,  8 as num from  cc_ptlog where ptid='${def:user}' and created::date=${fld:s_date}::date and status=1	and org_id=${def:org})
union all
(select count(*) as guest_daynum,  9 as num from  cc_ptlog where ptid='${def:user}'and  to_char(created, 'YYYY-MM') =to_char(${fld:s_date}, 'YYYY-MM') and status=1 and org_id=${def:org})
union all--私教签课数量




(select count(code) as guest_daynum,  10 as num from  cc_contract where salemember='${def:user}' and createdate::date=${fld:s_date}::date and status=2 and org_id = ${def:org})
union all
(select count(code) as guest_daynum,  11 as num from  cc_contract where salemember='${def:user}'and  to_char(createdate, 'YYYY-MM') =to_char(${fld:s_date}, 'YYYY-MM' ) and status=2 and org_id = ${def:org})
union all

(select COALESCE(sum(factmoney),0.0) as guest_daynum,  12 as num from  cc_contract where salemember='${def:user}' and createdate::date=${fld:s_date}::date and status=2	and org_id = ${def:org})
union all
(select  COALESCE(sum(factmoney),0.0) as guest_daynum,  13 as num from  cc_contract where salemember='${def:user}'and  to_char(createdate, 'YYYY-MM') =to_char(${fld:s_date}, 'YYYY-MM' ) and status=2 and org_id = ${def:org})

