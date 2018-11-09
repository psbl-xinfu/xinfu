delete from cc_trainplan_detail_group 
where
	code::varchar in (
		select regexp_split_to_table(${fld:groupcodes}, ',')
	)
