update cc_contract
set createdate=${fld:datetime}::date,--格式为:(2018-01-01)
		createtime=${fld:datetime}::time,--格式为:(12:12:12)
		collectdate=${fld:datetime}::date,--格式为:(2018-01-01)
		collecttime=${fld:datetime}::time--格式为:(12:12:12)
where code = (select contractcode from cc_card 
	where code = ${fld:cardcode} and org_id = ${def:org} and isgoon=0)