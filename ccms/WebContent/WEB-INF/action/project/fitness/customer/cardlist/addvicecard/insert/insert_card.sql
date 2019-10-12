insert into cc_card
(
	code,
	isgoon,
	customercode,
	cardtype,
	totalday,
	giveday,
	factmoney,
	count,
	passwd,
	status,
	remark,
	starttype,
	nowcount,
	stopdays,
	ckstartdate,
	ckenddate,
	startdate,
	enddate,
	savestartdate,
	relatecode,
	createdby,
	created,
	org_id,
	expercardcode
)
(
	select 
		${fld:cardcode},
		isgoon,
		(case when (select count(1) from cc_customer where mobile = ${fld:mobile} and org_id = ${def:org})<1 
			then concat(COALESCE((SELECT memberhead FROM hr_org WHERE org_id =${def:org}),''),lpad(currval('seq_cc_customer')::varchar, 8, '0')) 
			else (select code from cc_customer where mobile = ${fld:mobile} and org_id = ${def:org} limit 1) 
		end),
		cardtype,
		totalday,
		giveday,
		factmoney,
		count,
		passwd,
		status,
		remark,
		starttype,
		nowcount,
		stopdays,
		ckstartdate,
		ckenddate,
		startdate,
		enddate,
		savestartdate,
		${fld:relatecode},
		'${def:user}',
		{ts'${def:timestamp}'},
		org_id,
		expercardcode
	from cc_card 
	where code = ${fld:relatecode} and org_id = ${def:org}
)

