select 
	concat('<input type="radio" name="holidaylist" value="' , h.tuid , '" code2="', h.status, '" />') AS radio_link ,
	h.tuid,
	org.org_name,
	h.begintime,
	h.endtime,
	h.remark,
	h.created,
	(select name from hr_staff where userlogin = h.createdby and org_id = ${def:org}) as createdby,
	(case when h.status = 1 then '启用' else '禁用' end) as status
from hr_org_holiday h
left join hr_org org on h.org_id = org.org_id
where h.org_id = ${def:org} and h.status!=0
${filter}
${orderby}