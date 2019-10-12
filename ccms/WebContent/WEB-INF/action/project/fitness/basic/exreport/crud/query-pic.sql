(
	select 
		count(*) as lingnum
		from 
		cc_expercard_log l
		left join  cc_market_campaign m on m.code=l.market_campaign_code and m.org_id=${def:org}
		where 
		l.org_id=${def:org}
		and
		m.code=${fld:code}
) 

union all

(
	select count(*) from cc_inleft  lef
				left join cc_expercard_list list on   lef.cardcode=list.code	and  list.org_id=${def:org}
				where  list.market_campaign_code=${fld:code} and	lef.org_id=${def:org}
)

union all
(

	select count(*) from cc_contract  con
					where recommendcode in(select  createdby from  cc_share_log  where org_id=${def:org} and market_campaign_code=${fld:code})
					and con.org_id=${def:org} and con.status!=0
)

union all
(
	select 	case when 	sum(factmoney) is null then 0 else sum(factmoney) end
					from cc_contract  con
					where recommendcode in(select  createdby from  cc_share_log  where org_id=${def:org} and market_campaign_code=${fld:code})
					and con.org_id=${def:org} and con.status!=0
)

union all
(
	select 
	count(*) 
	from 
	cc_expercard_list l
	left join  cc_market_campaign m on m.code=l.market_campaign_code and m.org_id=${def:org}
	where 
	l.org_id=${def:org}
	and
	m.code=${fld:code}
)