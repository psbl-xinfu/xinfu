 select
 e.name as ename,
 e.startdate,
 e.enddate,
  e.useremark,
  
  e.contact_phone,
  e.address,
  e.org_name
 from
 cc_market_campaign m
 inner join cc_expercard e on m.expercardcode=e.code and m.org_id=e.org_id
 where 
 m.status=1 and  m.campaigntype=0
 and m.org_id = (select org_id from  cc_expercard_list where code=${fld:expercardcode}  )