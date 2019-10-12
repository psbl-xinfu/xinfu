insert into cc_customer
(
	code,
	name,
	mobile,
    sex,
	age,
	cardtype,
	card,
	urgent,
	othertel,
	indate,
	recommend,
	mc,
	pt,
	remark,
   	status,
	createdby,
	created,
   	org_id
)
(
	select
		concat(COALESCE((SELECT memberhead FROM hr_org WHERE org_id =${def:org}),''),lpad(nextval('seq_cc_customer')::varchar, 8, '0')),
		${fld:name},
		${fld:mobile},
		${fld:sex},
		${fld:age},
		${fld:cardtype},
		${fld:card},
		${fld:urgent},
		${fld:othertel},
		(select indate from cc_customer where mobile = ${fld:relatemobile} and org_id = ${def:org} limit 1),
		(select recommend from cc_customer where mobile = ${fld:relatemobile} and org_id = ${def:org} limit 1),
		(select mc from cc_customer where mobile = ${fld:relatemobile} and org_id = ${def:org} limit 1),
		(select pt from cc_customer where mobile = ${fld:relatemobile} and org_id = ${def:org} limit 1),
		${fld:remark},
		1,
		'${def:user}',
	    {ts'${def:timestamp}'},
		${def:org}
	from dual
	--根据当前手机号码查询是否存在该会员，如果不存在添加该会员
	where 0 = (select count(1) from cc_customer where mobile = ${fld:mobile} and org_id = ${def:org})
)



