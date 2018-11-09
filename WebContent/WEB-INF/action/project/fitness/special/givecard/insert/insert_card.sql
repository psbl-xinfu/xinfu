insert into cc_card(
	code,
	customercode,
	cardtype,
	status,
	createdby,
	created,
	remark,
	starttype,
	totalday,
	giveday,
	factmoney,
	count,
	org_id,
	startdate,
	enddate
)
values(
	concat(COALESCE((SELECT memberhead FROM hr_org WHERE org_id = ${def:org}),''), (case when (SELECT param_value FROM cc_config config WHERE
	config.category = 'IsCardCodeLimit' and config.org_id = (case when 
	not exists(select 1 from cc_config c where c.org_id = ${def:org} and c.category=config.category) 
	then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end))='0' then nextval('seq_cc_card')::varchar 
	else 
		(case when (SELECT param_value FROM cc_config config WHERE config.category = 'WhichSevenType'
			and config.org_id = (case when 
			not exists(select 1 from cc_config c where c.org_id = ${def:org} and c.category=config.category) 
			then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end))='0' then lpad(nextval('seq_cc_card')::varchar, 6, '0') 
			else lpad(nextval('seq_cc_card')::varchar, 5, '0') end)
	end)),
	${fld:customercode},
	${fld:cardtype},
	(case when ${fld:enablement}='0' then 1 else 2 end),
	 '${def:user}',
	 {ts'${def:timestamp}'},
	${fld:remark},
	${fld:enablement},
	  (case when ${fld:giveday} is null then 0 else  ${fld:giveday}  end   +    case when ${fld:daycount} is null then 0  else  ${fld:daycount} end),
	${fld:giveday},
	${fld:cardfee},
	${fld:count},
	${def:org},
	(case when ${fld:enablement}='2' then ${fld:startdate}::date 
		when ${fld:enablement}='0' then '${def:date}'::date 
	else null end),
	(case when ${fld:enablement}='2' then ${fld:enddate}::date 
	when ${fld:enablement}='0' then '${def:date}'::date +(case when ${fld:giveday} is null then 0 else  ${fld:giveday}  end   +    case when ${fld:daycount} is null then 0  else  ${fld:daycount} end)
		+${fld:giveday}
	else null end)
)
