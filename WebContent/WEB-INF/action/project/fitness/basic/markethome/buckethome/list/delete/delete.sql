delete from    cc_market_campaign
where
	code::varchar in (
		select regexp_split_to_table(${fld:id}, ';')
	)

