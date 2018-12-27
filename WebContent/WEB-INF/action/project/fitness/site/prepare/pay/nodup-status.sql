select 1 from cc_siteusedetail 
where code = concat((select memberhead from hr_org where org_id = ${def:org}), ${seq:nextval@seq_cc_siteusedetail}) and status=0 and org_id =${def:org}