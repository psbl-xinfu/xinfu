insert into cc_operatelog
(
	code,
	opertype,
	relatedetail,
   	createdate,
   	createtime,
	status,
   	createdby,
	remark,
	org_id
)
values 
(
	concat(COALESCE((SELECT memberhead FROM hr_org WHERE org_id = ${def:org}),''), ${seq:nextval@seq_cc_operatelog}),
   '20',
	concat(${fld:customercode}, ';', 
	concat(COALESCE((SELECT memberhead FROM hr_org WHERE org_id = ${def:org}),''), 
	(case when (SELECT param_value FROM cc_config config WHERE
	config.category = 'IsCardCodeLimit' and config.org_id = (case when 
	not exists(select 1 from cc_config c where c.org_id = ${def:org} and c.category=config.category) 
	then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end))='0' then currval('seq_cc_card')::varchar 
	else 
		(case when (SELECT param_value FROM cc_config config WHERE config.category = 'WhichSevenType'
			and config.org_id = (case when 
			not exists(select 1 from cc_config c where c.org_id = ${def:org} and c.category=config.category) 
			then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end))='0' then lpad(currval('seq_cc_card')::varchar, 6, '0') 
			else lpad(currval('seq_cc_card')::varchar, 5, '0') end)
	end)
	), ';', ${fld:why}, ';0.00'),
     '${def:date}',
     '${def:time}',
     1,
     '${def:user}',
    ${fld:remark},
    ${def:org}
)
