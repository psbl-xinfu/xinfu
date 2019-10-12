 select
 	concat('<input type="checkbox"  data-am-ucheck name="datalist" 
	   value="',cr.tuid,'" code="', cr.status,'" code2="', cr.isdeposit,'" >
	') as application_id,
 	g.groupname,
 	b.cabinetcode,
 	(case when cr.status=1 then '未退柜' else '已退柜' end) as status,
	cr.remark,
 	cr.startdate,
 	cr.enddate,
    cr.customercode,
	cust.name,
	cust.mobile,
	cr.createdby,
	cr.created,
	(case when cr.isdeposit = 1 then '已退押金' else '未退押金' end) as isdeposittype
from cc_cabinet_rent cr
inner join cc_cabinet b on cr.cabinetcode = b.cabinetcode and cr.org_id = b.org_id
inner join cc_cabinet_group g on g.tuid=b.groupid and g.org_id=${def:org}
left join cc_customer cust on cr.customercode = cust.code and cr.org_id = cust.org_id
where cr.org_id=${def:org} and cr.is_deleted = 0
${filter}
${orderby}



