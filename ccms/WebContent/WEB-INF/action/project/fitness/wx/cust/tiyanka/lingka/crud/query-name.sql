  select
  g.name
 from
 cc_market_campaign m
inner join cc_expercard_log g  on  g.market_campaign_code=m.code and g.org_id=m.org_id
inner join cc_expercard_list l    on  l.expercard_log_code=g.code and g.org_id=l.org_id 
 where 
 m.status=1
  and m.campaigntype=0
 and  l.code=${fld:expercardcode}
 
 and m.org_id = (select org_id from  cc_expercard_list where code=${fld:expercardcode}  )
 

