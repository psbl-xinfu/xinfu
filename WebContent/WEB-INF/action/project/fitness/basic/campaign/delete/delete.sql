delete from cc_campaign
where
	code in (
		select regexp_split_to_table(${fld:id}, ',')
	)
	and org_id = ${def:org}

