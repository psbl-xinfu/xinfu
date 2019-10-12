select
	code,
	concat('<input type="checkbox" name="kqlist" value="', code, '" "/>') AS checklink,
	rules_name,
	(case isrules when 0 then '固定值' when 1 then '百分比' else '' end) isrules,
	(case isrules when 0 then fixed_value when 1 then percent_value else null end) deduction,
	remark,
	(case status when 1 then '已启用' when 0 then '已禁用' else '' end) status
from cc_classkq
where org_id = ${def:org}
${filter}
${orderby}


