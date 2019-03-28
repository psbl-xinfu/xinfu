select (concat(COALESCE((select memberhead from hr_org where org_id = ${def:org}),''), ${fld:cc_mobile})) as userlogin,user_id from ${schema}s_user
where userlogin = ${fld:userlogin}
