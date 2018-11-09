(select count(*) as guest_daynum,  0 as num  from  cc_guest where mc='${def:user}' and created::date=${fld:s_date})
union all
(select count(*) as guest_daynum,  1 as num from  cc_guest where mc='${def:user}'and    to_char(created, 'YYYY-MM') =to_char(${fld:s_date}, 'YYYY-MM'))
union all

(select count(*) as guest_daynum,  2 as num from  cc_comm where createdby='${def:user}' and created::date=${fld:s_date}::date)
union all
(select count(*) as guest_daynum,  3 as num from  cc_comm where createdby='${def:user}'and  to_char(created, 'YYYY-MM') =to_char(${fld:s_date}, 'YYYY-MM'))
union all

(select count(*) as guest_daynum,  4 as num from  cc_guest_prepare where createdby='${def:user}' and created::date=${fld:s_date}::date )
union all
(select count(*) as guest_daynum,  5 as num from  cc_guest_prepare where createdby='${def:user}'and  to_char(created, 'YYYY-MM') =to_char(${fld:s_date}, 'YYYY-MM'))
union all

(select count(*) as guest_daynum,  6 as num from  cc_guest_prepare where createdby='${def:user}' and created::date=${fld:s_date}::date and status=4	 )
union all
(select count(*) as guest_daynum,  7 as num from  cc_guest_prepare where createdby='${def:user}'and  to_char(created, 'YYYY-MM') =to_char(${fld:s_date}, 'YYYY-MM') and status=4)
union all

(select count(*) as guest_daynum,  8 as num from  cc_contract where salemember='${def:user}' and createdate::date=${fld:s_date}::date and status=2	 )
union all
(select count(*) as guest_daynum,  9 as num from  cc_contract where salemember='${def:user}'and  to_char(createdate, 'YYYY-MM') =to_char(${fld:s_date}, 'YYYY-MM' )and status=2)
union all

(select COALESCE(sum(factmoney),0.0) as guest_daynum,  10 as num from  cc_contract where salemember='${def:user}' and createdate::date=${fld:s_date}::date and status=2	 )
union all
(select COALESCE(sum(factmoney),0.0) as guest_daynum,  11 as num from  cc_contract where salemember='${def:user}'and  to_char(createdate, 'YYYY-MM') =to_char(${fld:s_date}, 'YYYY-MM' )and status=2)

