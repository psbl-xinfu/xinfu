 select
 m.code,
 e.name,
 e.code as ecode,
 (case when  e.expertype=0 then '时效卡' when  e.expertype=1 then '计次卡' when  e.expertype=2 then '私教免费课' end)as cardtype,
  e.experlimit,
  e.enddate,
  personnum
 from
 cc_market_campaign m
 inner join cc_expercard e on m.expercardcode=e.code and e.org_id=m.org_id
 where 
 m.status=1
 and 
 m.campaigntype=0 
and m.org_id =
	(select distinct org_id from cc_testresult where code in (
 	select regexp_split_to_table(${fld:codes}, ';')) limit 1) 


