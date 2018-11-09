insert into cc_cardcode
(
	tuid,
	incode,
	cardcode,
	status,
	org_id
)
(
	select
		${seq:nextval@seq_cc_cardcode},	
		${fld:incode},
		${fld:cardcode},
		1,
		${def:org}
	from dual 
	where ${fld:incode} is not null
)



