with campaigndata as (
	select code,org_id from cc_market_campaign m 
	where  status=1 
	and m.campaigntype=0 
	and m.org_id = (
			select distinct org_id from cc_testresult where code in (
	 			select regexp_split_to_table(${fld:codes}, ';')
	 		) limit 1
	 ) limit 1
) 

(
	select
	count(1) as usenum
	from cc_expercard_list
	where market_campaign_code = (select code from campaigndata)
)

union all

(
	select
	count(1) as usenum
	from cc_expercard_list  list
	left join  cc_expercard_log  log on log.code=list.expercard_log_code and list.org_id = log.org_id
	where list.market_campaign_code = (select code from campaigndata)
	and list.org_id = (select org_id from campaigndata) 
	and log.mobile=${fld:cc_mobile}
)
