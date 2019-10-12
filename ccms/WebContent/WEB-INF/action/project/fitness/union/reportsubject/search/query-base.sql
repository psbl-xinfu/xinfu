select 
	concat('<input type="checkbox" name="rslist" " value="', rs.tuid, '" "/>') AS checklink,
	rs.subjectname,
	rs.grade,
	(case when rs.status=1 then '已启用' when rs.status=2 then '已禁用'  end) as status,
	rs.showorder,
	rs.tuid,
	(select subjectname from cc_report_subject where tuid = rs.pid and org_id = ${def:org}) as pname,
	(case when rs.pid is null then 0 else rs.pid end) as pid,
	(case when rs.category=0 then '收入' else '支出' end) as category
from cc_report_subject rs
where rs.status!=0 and rs.org_id = ${def:org} and rs.category = ${fld:category}
${filter}
${orderby}
