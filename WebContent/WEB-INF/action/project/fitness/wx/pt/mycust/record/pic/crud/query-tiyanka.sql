 select
 m.code,
 e.code as ecode,
 e.name as ename,
 m.startdate,
 m.enddate,
  (case when m.totalnum::varchar is null  then '' else m.totalnum::varchar end) as totalnum
 from
 cc_market_campaign m
 left join cc_expercard e on m.expercardcode=e.code and e.org_id=m.org_id
 where m.org_id = ${def:org} 
and m.status=1
and m.campaigntype=0

