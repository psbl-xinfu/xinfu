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
		${fld:new_vc_code},
		1,
		${def:org}
	from dual
	where (case when ${fld:incode} is null then 1=2 else 1=1 end)
)
