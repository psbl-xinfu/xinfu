update    cc_cardcategory
set status = 0 
where
	code::varchar in (
		select regexp_split_to_table(${fld:id}, ';')
	)



