DELETE FROM cc_guest WHERE code::varchar in (
		select regexp_split_to_table(${fld:id}, ',')
	)