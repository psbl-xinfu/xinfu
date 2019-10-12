update    hr_staff
set status = 2 
where
	user_id::varchar in (
		select regexp_split_to_table(${fld:id}, ';')
	)

