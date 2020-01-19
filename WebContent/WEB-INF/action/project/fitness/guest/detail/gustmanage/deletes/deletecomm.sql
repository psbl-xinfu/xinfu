DELETE FROM cc_comm WHERE guestcode::varchar in (
		select regexp_split_to_table(${fld:id}, ',')
	)