select 
	cs.prepare_date,
	to_char(cs.prepare_starttime, 'HH24:mm') as prepare_starttime,
	to_char(cs.prepare_endtime, 'HH24:mm') as prepare_endtime,
	(select org_name from hr_org where org_id = cs.org_id) as org_name,
	(select sitename from cc_sitedef where code = cs.sitecode and org_id = cs.org_id) as sitename
from cc_siteusedetail cs
where cs.guestgroupid = ${fld:groupid} and cs.org_id = ${fld:org_id}
order by cs.prepare_date desc