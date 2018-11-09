select
	(case
		when (select user_id from hr_staff where weixin_lastlogin = ${fld:weixin_userid}) is not null
		then (select name from cc_customer where user_id = 
				(select user_id from hr_staff where weixin_lastlogin = ${fld:weixin_userid}) and org_id = ${fld:org_id})
		else (select name from cc_guest where weixinlogin = ${fld:weixin_userid} and org_id = ${fld:org_id})
	end) as name,
	(case
		when (select user_id from hr_staff where weixin_lastlogin = ${fld:weixin_userid}) is not null
		then (select mobile from cc_customer where user_id = 
				(select user_id from hr_staff where weixin_lastlogin = ${fld:weixin_userid}) and org_id = ${fld:org_id})
		else (select mobile from cc_guest where weixinlogin = ${fld:weixin_userid} and org_id = ${fld:org_id})
	end) as mobile