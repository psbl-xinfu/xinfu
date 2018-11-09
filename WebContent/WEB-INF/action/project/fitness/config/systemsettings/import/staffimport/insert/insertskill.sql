insert into hr_staff_skill
(
  tuid,
  user_id,
  userlogin,
  skill_id,
  isclass,
  created,
  createdby
)
values
(
	${seq:nextval@seq_hr_staff_skill},
	${seq:currval@${schema}seq_user},
	${fld:userlogin},
	${fld:skill},
	0,
	{ts '${def:timestamp}'},
	'${def:user}'
)