 select
 m.code,
 e.code as ecode,
 e.name,
 m.startdate,
 m.enddate,
 m.totalnum--数量
 from
 cc_market_campaign m
 left join cc_expercard e on m.expercardcode=e.code and e.org_id=m.org_id
 where m.org_id = (select distinct org_id from cc_testresult where code in (
 	select regexp_split_to_table(${fld:codes}, ';')
 ) limit 1) 
and m.status=1
and m.campaigntype=0
