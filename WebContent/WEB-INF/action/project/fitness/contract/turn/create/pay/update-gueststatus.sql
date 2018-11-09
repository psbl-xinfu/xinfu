update cc_guest
set status=99
where code = (select guestcode from cc_contract where code = ${fld:contractcode} and org_id = ${def:org}) 
and org_id = ${def:org}