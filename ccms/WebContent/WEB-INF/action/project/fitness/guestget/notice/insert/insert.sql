INSERT INTO cc_hkb_notice_log(
	tuid,
	notice_id,
	user_id,
	userlogin,
	created,
	org_id
) 
(
	select 
		${seq:nextval@seq_cc_hkb_notice_log},
		${fld:tuid},
		(select user_id from hr_staff where userlogin = '${def:user}' and org_id = ${def:org}),
		'${def:user}',
		{ts '${def:timestamp}'},
		${def:org}
	from dual
	where (select count(1) from cc_hkb_notice_log 
		where notice_id = ${fld:tuid} and userlogin = '${def:user}' and org_id = ${def:org})=0
)