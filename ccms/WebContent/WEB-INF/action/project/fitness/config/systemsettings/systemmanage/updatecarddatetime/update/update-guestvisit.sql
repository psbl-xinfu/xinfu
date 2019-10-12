update cc_guest_visit
set visitdate=${fld:datetime}::date,--格式为:(2018-01-01)
		visittime=${fld:datetime}::time,--格式为:(12:12:12)
		created=${fld:datetime}::timestamp--格式为:(2018-01-01 12:12:12)
where guestcode = (select guestcode from cc_customer where code = 
(select customercode from cc_card where code = ${fld:cardcode} 
	and org_id = ${def:org} and isgoon=0))