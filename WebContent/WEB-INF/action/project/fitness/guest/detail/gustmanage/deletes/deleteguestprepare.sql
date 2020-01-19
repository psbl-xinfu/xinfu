DELETE FROM cc_guest_prepare WHERE guestcode::varchar in (
		select regexp_split_to_table(${fld:id}, ',')
	)