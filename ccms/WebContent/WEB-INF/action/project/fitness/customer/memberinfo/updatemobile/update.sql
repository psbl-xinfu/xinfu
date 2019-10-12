--zzn 20190327
 update ${schema}s_user set 
	fname= ${fld:cc_name}
	,userlogin=concat(COALESCE((select memberhead from hr_org where org_id = ${def:org}),''), ${fld:cc_mobile})
	 	
where
	user_id = ${fld:user_id}
	
	
	
	
	
	
	
