--zzn 20190327
 update "security".s_user set 
	fname= ${fld:cc_name}
	,userlogin=concat(COALESCE((select memberhead from hr_org where org_id = '${def:org}'),''), ${fld:cc_mobile})
--	,passwd=${fld:passwd} 	
where
	user_id = (select user_id from cc_customer where code=${fld:cc_code} and org_id = '${def:org}')
	
	
	
	
	
	
	
