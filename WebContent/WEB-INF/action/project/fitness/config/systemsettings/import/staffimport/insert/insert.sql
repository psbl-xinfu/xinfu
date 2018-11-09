insert into hr_staff
(
	sex,--性别
	user_pinyin,--工号
    user_id,
    userlogin,--登录名
    name,--姓名
    name_en,--别名
    mobile,--电话
    remark,--备注
    status,
    entry_date,
    org_id,
    created,
    createdby
)
values 
(
	${fld:sex},
	${fld:user_pinyin},
	${seq:nextval@${schema}seq_user},
    ${fld:userlogin},
    ${fld:name},
    ${fld:name_en},
    ${fld:mobile},
    ${fld:remark},
    ${fld:status},
    '${def:date}',
 	${def:org},
	{ts '${def:timestamp}'},
	'${def:user}'
)
