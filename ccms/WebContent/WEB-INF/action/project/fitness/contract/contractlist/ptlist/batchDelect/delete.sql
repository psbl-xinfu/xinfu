update cc_contract 
set status = 0 
where
	code in (
		select regexp_split_to_table(${fld:id}, ',')
	)
