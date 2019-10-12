 and
		(case when ${fld:s_status}=0 then
		
			exists (
				select 1 from cc_inleft  lef
				left join cc_expercard_list list on   lef.cardcode=list.code and  list.org_id=${def:org}
				where  list.market_campaign_code=${fld:s_code} and lef.org_id=${def:org}
			)
		else
			not exists (
				select 1 from cc_inleft  lef
				left join cc_expercard_list list on   lef.cardcode=list.code	and list.org_id=${def:org}
				where  list.market_campaign_code=${fld:s_code} and	lef.org_id=${def:org}
			)
		end
	)