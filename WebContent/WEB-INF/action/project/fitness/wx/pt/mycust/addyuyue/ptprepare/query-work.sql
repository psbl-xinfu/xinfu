SELECT count(1) as work FROM dual 
WHERE not (concat(${fld:preparedate}, ':', ${fld:preparetime})::time>=(SELECT
   config.param_value::time
FROM
	cc_config config
WHERE
	config.category = 'PTStartTime'
and 
	config.org_id = (case when 
	not exists(select 1 from cc_config c where c.org_id = ${def:org} and c.category=config.category) 
	then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end))
and 
	(concat(${fld:preparedate}, ':', ${fld:preparetime})::time+ ((select times from cc_ptdef where code = (select ptlevelcode from cc_ptrest where code = ${fld:ptrestcode} and org_id = ${def:org}) and org_id = ${def:org})||' minutes')::interval)<= (SELECT
   config.param_value::time
FROM
	cc_config config
WHERE
	config.category = 'PTEndTime'
and 
	config.org_id = (case when 
	not exists(select 1 from cc_config c where c.org_id = ${def:org} and c.category=config.category) 
	then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end))
)

