update    cc_contract
set isaudit = ${fld:c_status},
	auditby='${def:user}',
	audittime={ts'${def:timestamp}'}
where
	code::varchar in (
		select regexp_split_to_table(${fld:id}, ',')
	)

