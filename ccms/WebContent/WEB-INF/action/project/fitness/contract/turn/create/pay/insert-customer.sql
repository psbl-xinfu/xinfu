insert into cc_customer(
	code,
	guestcode,
	name,
	nation,
	sex,
	officetel,
	mobile,
	email,
	status,
	moneyleft,
	remark,
	zip,
	mc,
	indate,
	salemember,
	createdby,
	created,
	age,
	gethobbit,
	personalhobbit,
	marriage,
	children,
	leave,
	birth,
	birthday,
	wx,
	qq,
	cardtype,
	card,
	nationality,
	occupation,
	province,
	city,
	region,
	officename,
	province2,
	city2,
	region2,
	officeaddr,
	urgent,
	addr,
	aim,
	othertel,
	moneycash,
	moneygift,
	recommend,
	type,
	org_id
) 
select 
	concat(COALESCE((SELECT memberhead FROM hr_org WHERE org_id =${def:org}),''),lpad(nextval('seq_cc_customer')::varchar, 8, '0')),
	code,
	name,
	nationality,	-- nation
	sex,
	officetel,
	mobile,
	email,
	1,	/** status，未付款前默认无效*/
	0.00,	-- moneyleft
	remark,	-- remark
	NULL,	-- zip
	'${def:user}',	-- mc
	{d '${def:date}'},	-- indate
	'${def:user}',	-- salemember
	'${def:user}',
	{ts '${def:timestamp}'},
	age,
	gethobbit,
	personalhobbit,
	marriage,
	children,
	leave,
	birth,
	birthday,
	wx,
	qq,
	cardtype,
	card,
	nationality,
	occupation,
	province,
	city,
	region,
	officename,
	province2,
	city2,
	region2,
	officeaddr,
	urgent,
	addr,
	purpose,
	othertel,
	0.00,	-- moneycash
	0.00,	-- moneygift
	recommend,
	type,
	org_id 
from cc_guest 
where code = (select guestcode from cc_contract where code = ${fld:contractcode} and org_id = ${def:org}) and org_id =${def:org}
