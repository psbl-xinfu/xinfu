update
	cc_campaign
SET
	is_enabled = 1
where
	code in (
		select regexp_split_to_table(${fld:id}, ';')
	)
	and org_id = ${def:org}
