delete from    cc_expercard
where
	code::varchar in (
		select regexp_split_to_table(${fld:id}, ',')
	)

