 select
	concat('<input type="checkbox"  data-am-ucheck name="r_datalist" 
		code="',b.status,'" value="',b.tuid::varchar,'','" >') as application_id,
 	g.groupname,
 	g.groupcode as gid,
 	b.cabinettempcode as bid,
 	(case when b.status=0 then '空闲' when b.status=1 then '已占用' when b.status=2 then '无效'  else '其他'  end)as status,
 	(case when cust.name is null then (case when el.name is not null then concat(el.name, '（体验卡）') else '' end) else cust.name end) as name,
 	(case when cust.mobile is null then el.mobile else cust.mobile end) as mobile,
 	(case when b.physics_status=0 then '损坏'  else '正常'  end)as physics_status
from cc_cabinettemp b
left join cc_cabinettemp_group g on g.tuid=b.groupid and g.org_id=b.org_id
left join cc_customer cust on b.customercode=cust.code and b.org_id = cust.org_id
left join cc_expercard_log el on el.code = b.customercode and b.org_id = el.org_id
where b.status!=2 and b.org_id=${def:org}
${filter}
${orderby}



