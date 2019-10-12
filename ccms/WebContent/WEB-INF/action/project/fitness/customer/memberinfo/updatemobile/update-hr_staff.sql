 --zzn 20190327
 update hr_staff set 
	 name= ${fld:cc_name}
	,mobile= ${fld:cc_mobile}
	,sex=${fld:cc_sex}
	,userlogin=concat(COALESCE((select memberhead from hr_org where org_id = ${def:org}),''), ${fld:cc_mobile})
where
	user_id = (select user_id from cc_customer where code=${fld:cc_code} and org_id = ${def:org}) and is_member='1'

	
	
	
	
