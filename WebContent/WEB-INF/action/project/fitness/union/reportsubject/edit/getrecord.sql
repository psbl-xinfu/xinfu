select 
	rs.tuid,
	rs.subjectname,
	rs.showorder,
	rs.remark
from cc_report_subject rs
where rs.tuid = ${fld:tuid} and rs.org_id = ${def:org}
