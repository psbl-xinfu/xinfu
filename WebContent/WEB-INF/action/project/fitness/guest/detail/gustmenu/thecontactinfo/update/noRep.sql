select 1 from cc_thecontact where mobile=${fld:cc_mobile} and org_id=${def:org}
and not exists(select 1 from cc_thecontact where mobile = ${fld:cc_mobile} and org_id=${def:org})

