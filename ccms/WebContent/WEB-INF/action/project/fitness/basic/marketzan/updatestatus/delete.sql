update   cc_market_campaign set
status=${fld:c_status}
where
	code::varchar in (
		select regexp_split_to_table(${fld:id}, ';')
	)

