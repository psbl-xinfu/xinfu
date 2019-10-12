select
	name,
	mobile,
	l.created,
	(select name from cc_customer where code=
		(select createdby from cc_share_log where l.sharecode=cc_share_log.code)) as name2,
	
		
	(select mobile from cc_customer where code=
		(select createdby from cc_share_log where l.sharecode=cc_share_log.code)) as mobile2,
		
	(
		select intime from cc_inleft lef
				inner join cc_expercard_list list on lef.cardcode=list.code	and  list.org_id=1003
				where list.expercard_log_code=l.code and lef.org_id=${def:org} limit 1
	)as intime
from cc_expercard_log l 
inner join cc_expercard_list  list  on  list.expercard_log_code=l.code  and list.org_id=${def:org}
where l.org_id=${def:org}
and l.market_campaign_code=${fld:daochu_code}
${filter}
order by created desc



