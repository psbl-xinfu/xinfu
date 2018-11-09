select 
	t.tuid
from t_attachment_files t 
where t.pk_value = (
		case
		when (select user_id from hr_staff where weixin_lastlogin = ${fld:weixin_userid}) is not null
		then (select code from cc_customer where user_id = 
				(select user_id from hr_staff where weixin_lastlogin = ${fld:weixin_userid}) and org_id = ${fld:org_id})
		else (select code from cc_guest where weixinlogin = ${fld:weixin_userid} and org_id = ${fld:org_id})
		end
	)
and t.table_code = (
		case
		when (select user_id from hr_staff where weixin_lastlogin = ${fld:weixin_userid}) is not null
		then 'cc_customer' 
		else 'cc_guest' 
		end
	)
and t.org_id= ${fld:org_id}
order by t.tuid desc limit 1