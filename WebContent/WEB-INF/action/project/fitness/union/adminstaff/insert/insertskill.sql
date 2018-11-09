insert into hr_staff_skill
(
  tuid,
  user_id,
  userlogin,
  skill_id,
  created,
  createdby
)
values
(
  ${seq:nextval@seq_hr_staff_skill},
  ${seq:currval@${schema}seq_user},
  ${fld:userlogin},
  (select skill_id from hr_skill where skill_scope = '4' and skill_name like '%管理员%' limit 1),
	{ts '${def:timestamp}'},
	'${def:user}'
)