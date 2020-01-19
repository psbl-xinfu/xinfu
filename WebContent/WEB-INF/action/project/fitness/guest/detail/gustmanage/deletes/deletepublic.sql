DELETE FROM cc_public WHERE guestcode::varchar in (
		select regexp_split_to_table(${fld:id}, ',')
	)