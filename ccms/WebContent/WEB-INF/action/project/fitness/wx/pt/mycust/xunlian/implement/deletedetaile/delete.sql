delete from cc_trainplan_detail 
where
	code::varchar in (
		select regexp_split_to_table(${fld:detailecodes}, ',')
	)
