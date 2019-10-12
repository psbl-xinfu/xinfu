select 
	elist.code,
	elog.name,
	elog.mobile,
	e.name as expercardname,
	elist.expertype,
	elist.experlimit,
	(case when elist.status=1 then '正常' when elist.status=2 then '未启用'
	 when elist.status=4 then '挂失中' when elist.status=5 then '停卡中' end) as status,
	(case when ((mc.startdate<='${def:date}'::date and mc.enddate>='${def:date}'::date and mc.validatetype=1) or mc.validatetype=0) 
	 	then (case when e.validatetype=0 then '1'
	 		 	   when (e.validatetype=1 and elist.startdate<='${def:date}'::date and elist.enddate>='${def:date}'::date) then '1'
	 		 	   when (e.validatetype=2 and elist.startdate<='${def:date}'::date and elist.enddate>='${def:date}'::date) then '1'
	 		 	   else '2'
	 		end) else '2' end) as cardstatus,
	e.expertype,
	elist.expercarddef_code,
	elist.enddate,
	(select org_name from hr_org where org_id = elist.org_id) as org_name,
	elog.code as expercardlogcode,
	(select (case when lefttime is null then '1' else '2' end)
		from cc_inleft where org_id = elist.org_id and indate = {d '${def:date}'} and cardcode = elist.code order by intime desc LIMIT 1) as entrancetype,
	elist.org_id,
	(select (case when lefttime is null then (select tuid from cc_cabinettemp where tuid::varchar = cc_inleft.cabinettempcode and org_id = elist.org_id)::varchar else '' end)
		from cc_inleft where indate = '${def:date}'::date and cardcode = elist.code and org_id = elist.org_id order by intime desc LIMIT 1) as cabinettempcode
from cc_expercard_list elist
left join cc_expercard_log elog on elist.code = elog.expercardcode and elist.org_id = elog.org_id
left join cc_expercard e on elist.expercarddef_code = e.code and elist.org_id = e.org_id
left join cc_market_campaign mc on mc.expercardcode = e.code and mc.org_id = e.org_id
where elist.code = ${fld:code} and elist.org_id = ${def:org} and elist.status in (1, 2, 4, 5) 


