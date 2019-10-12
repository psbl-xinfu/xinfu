select 1 from dual where
(select 
	(case when ((mc.startdate<='${def:date}'::date and mc.enddate>='${def:date}'::date and mc.validatetype=1) or mc.validatetype=0) 
	 	then (case when e.validatetype=0 then '1'
	 		 	   when (e.validatetype=1 and elist.startdate<='${def:date}'::date and elist.enddate>='${def:date}'::date) then '1'
	 		 	   when (e.validatetype=2 and elist.startdate<='${def:date}'::date and elist.enddate>='${def:date}'::date) then '1'
	 		 	   else '2'
	 		end) else '2' end) as cardstatus
from cc_expercard_list elist
left join cc_expercard_log elog on elist.code = elog.expercardcode and elist.org_id = elog.org_id
left join cc_expercard e on elist.expercarddef_code = e.code and elist.org_id = e.org_id
left join cc_market_campaign mc on mc.expercardcode = e.code and mc.org_id = e.org_id
where elist.code = ${fld:cardcode} and elist.org_id = ${def:org} and elist.status = 1) != '1'


