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
	contractcode,
	nowcount,
	stopdays,
	ckstartdate,
	ckenddate,
	startdate,
	enddate,
	savestartdate,
	relatecode,
	org_id,
	created,
   	createdby,
	expercardcode
)
(
	select 
		${fld:new_vc_code},
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
		contractcode,
		nowcount,
		stopdays,
		ckstartdate,
		ckenddate,
		startdate,
		enddate,
		savestartdate,
		relatecode,
		org_id,
		{ts'${def:timestamp}'},
		'${def:user}',
		expercardcode
	from cc_card 
	where code = ${fld:cardcode} and org_id = ${def:org}
)
