select 1 from cc_thecontact where mobile2=${fld:cc_mobile2} and org_id=${def:org}
and not exists(select 1 from cc_thecontact where mobile2 = ${fld:cc_mobile2} and org_id=${def:org})

