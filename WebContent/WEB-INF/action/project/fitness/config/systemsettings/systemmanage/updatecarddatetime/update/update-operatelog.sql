update cc_operatelog
set createdate=${fld:datetime}::date,--格式为:(2018-01-01)
		createtime=${fld:datetime}::time--格式为:(12:12:12)
where customercode=(select code from cc_customer 
where code = (select customercode from cc_card where code = ${fld:cardcode} 
and org_id = ${def:org} and isgoon=0)
and org_id = ${def:org}) and org_id=${def:org}