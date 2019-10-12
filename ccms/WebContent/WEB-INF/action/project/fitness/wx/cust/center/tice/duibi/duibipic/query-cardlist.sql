select
count(1) as usenum
from
cc_expercard_list
where
market_campaign_code=(
	select code from cc_market_campaign  
	where  status=1 and campaigntype=0 and org_id = (select distinct org_id from cc_testresult where code in (
	 	select regexp_split_to_table(${fld:codes}, ';')
	 ) limit 1) )
