select 
	concat((select cust.name from cc_customer cust where cust.code = code.val and cust.org_id = ${def:org}), '，',
	(select guest.name from cc_guest guest where guest.code = code.val and guest.org_id = ${def:org})) as val
from
(select regexp_split_to_table(${fld:id},',') as val from dual) code
inner join (select pk_value from cc_return_log 
		where org_id = ${def:org} and to_char(created, 'yyyy-MM')=to_char('${def:date}'::date, 'yyyy-MM')
	) rl on rl.pk_value = code.val
	

