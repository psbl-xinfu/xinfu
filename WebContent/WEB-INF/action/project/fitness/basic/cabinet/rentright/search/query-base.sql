 select
	concat('<input type="checkbox"  data-am-ucheck name="r_datalist" 
		code="',b.status,'" value="',b.tuid::varchar,'','" >') as application_id,
 	g.groupname,
 	g.groupcode as gid,
 	b.cabinetcode as bid,
	b.price, 	
	(case when b.physics_status=0 then '损坏'  else '正常'  end)as physics_status,
	(case when b.status=1 then
		 	(select r.startdate from cc_cabinet_rent r where r.org_id=${def:org} 
		 	and r.cabinetcode=b.cabinetcode::varchar order by r.created desc limit 1)
	end)as startdate,
	(case when b.status=1 then
		 	(select r.enddate from cc_cabinet_rent r where r.org_id=${def:org} 
		 	and r.cabinetcode=b.cabinetcode::varchar order by r.created desc limit 1)
	end)as enddate,
	(case when b.status=1 then
		 	(select c.name from cc_cabinet_rent r left join cc_customer c 
		 	on c.code=r.customercode where c.org_id=${def:org} 
		 	and r.cabinetcode=b.cabinetcode::varchar order by r.created desc limit 1)
	end)as name,
	(case when b.status=1 then
		 	(select c.mobile from cc_cabinet_rent r left join cc_customer c on  c.code=r.customercode 
		 	where c.org_id=${def:org} and r.cabinetcode=b.cabinetcode::varchar order by r.created desc limit 1)
	end)as mobile,
 	(case when b.status=0 then '空闲' when b.status=1 and
 		(select r.enddate from  cc_cabinet_rent r
 		where r.cabinetcode::varchar=b.cabinetcode and r.org_id=${def:org} order by r.created desc limit 1)<{ts'${def:timestamp}'}::date 
 	  	then '过期' when b.status=1 then '已占用' when b.status=2 then '无效'  else '其他'  end)as status
from
cc_cabinet b
left join cc_cabinet_group g on g.tuid=b.groupid and g.org_id=${def:org}
where b.org_id=${def:org} and b.status in (0, 1, 3)
${filter}
${orderby}



