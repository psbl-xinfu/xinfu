update cc_card set 
	startdate= ${fld:startdate},
	enddate= ${fld:startdate}::date+totalday+giveday,
	status=1
where
	code in (
		select regexp_split_to_table(${fld:id}, ',')
	)
and org_id = ${def:org} and isgoon = 0