 select
 	g.groupname,
 	b.cabinetcode,
 	'已占用' as status,
 	(select  r.remark from cc_cabinet_rent r where  r.org_id=${def:org} and   r.is_deleted=0 and r.cabinetcode=b.cabinetcode::varchar order by created desc limit 1)as remark,
 	(select  r.startdate from cc_cabinet_rent r where  r.org_id=${def:org} and   r.is_deleted=0 and r.cabinetcode=b.cabinetcode::varchar order by created desc limit 1)as startdate,
 	(select  r.enddate from cc_cabinet_rent r where  r.org_id=${def:org} and  r.is_deleted=0 and r.cabinetcode=b.cabinetcode::varchar order by created desc limit 1)as enddate,
 	(select  r.customercode from cc_cabinet_rent r where  r.org_id=${def:org} and  r.is_deleted=0 and r.cabinetcode=b.cabinetcode::varchar limit 1)as customercode,
	(select  c.name from cc_cabinet_rent r left join cc_customer c on  c.code=r.customercode   where  c.org_id=${def:org} and  r.is_deleted=0 and r.cabinetcode=b.cabinetcode::varchar  limit 1)as name,
    (select  c.mobile from cc_cabinet_rent r left join cc_customer c on  c.code=r.customercode   where  c.org_id=${def:org} and  r.is_deleted=0 and r.cabinetcode=b.cabinetcode::varchar  limit 1)as mobile,
    (select  r.createdby from cc_cabinet_rent r where  r.org_id=${def:org} and   r.is_deleted=0 and r.cabinetcode=b.cabinetcode::varchar order by created desc limit 1)as createdby,
    (select  r.created from cc_cabinet_rent r where  r.org_id=${def:org} and   r.is_deleted=0 and r.cabinetcode=b.cabinetcode::varchar order by created desc limit 1)as created
from cc_cabinet b
left join cc_cabinet_group g on g.tuid=b.groupid and g.org_id=${def:org}
where b.org_id=${def:org} and b.status=1
and b.cabinetcode = (select cabinetcode from cc_cabinet_rent 
	where tuid = ${fld:code}::int and org_id = ${def:org})


