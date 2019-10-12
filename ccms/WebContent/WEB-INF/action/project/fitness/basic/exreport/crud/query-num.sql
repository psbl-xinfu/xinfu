	select
		case when totalnum is null then 0 else totalnum end
		from 
		cc_market_campaign 
		where 
		org_id=${def:org}
		and
		code=${fld:code}

