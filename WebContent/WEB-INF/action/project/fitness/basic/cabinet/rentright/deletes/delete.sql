update cc_cabinet 
set status = 2
where
	tuid::varchar in (
		select regexp_split_to_table(${fld:id}, ',')
	)
