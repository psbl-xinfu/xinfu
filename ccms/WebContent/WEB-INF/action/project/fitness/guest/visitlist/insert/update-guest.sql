update cc_guest set sex=${fld:sex},type=${fld:cc_type},mc=${fld:cc_mc}
where mobile=${fld:mobile} and org_id=${def:org}