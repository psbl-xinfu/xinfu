 select
 totalnum, --数量
 personnum,
 org_id 
 from
 cc_market_campaign m
 where  m.org_id =
	(select distinct org_id from cc_testresult where code in (
 	select regexp_split_to_table(${fld:codes}, ';')) limit 1) 
and status=1
 and 
 m.campaigntype=0

