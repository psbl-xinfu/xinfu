update cc_guest
set created=${fld:datetime}::timestamp--格式为:(2018-01-01 12:12:12)
where code=(select guestcode from cc_customer where code = 
(select customercode from cc_card 
	where code = ${fld:cardcode} and org_id = ${def:org} and isgoon=0))