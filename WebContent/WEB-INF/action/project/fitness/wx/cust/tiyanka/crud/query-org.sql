 select
e.org_name 
 from
 cc_market_campaign m
 inner join cc_expercard e on m.expercardcode=e.code and m.org_id=e.org_id
 where 
 m.status=1
  and 
 m.campaigntype=0 
and m.org_id =

(case when ${fld:codes} is not null then 
	 (select distinct org_id from cc_testresult where code in (
 	 select regexp_split_to_table(${fld:codes}, ';')) limit 1) 
 	 else
 	 (select org_id from cc_customer where code=${fld:customercode})
end)
