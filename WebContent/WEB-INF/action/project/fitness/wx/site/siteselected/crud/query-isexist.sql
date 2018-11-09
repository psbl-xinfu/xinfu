select 
	(
	(select count(1) from cc_guest where org_id = ${fld:org_id} and weixinlogin = ${fld:weixin_userid})
	+
	(select count(1) from hr_staff where weixin_lastlogin = ${fld:weixin_userid} and org_id = ${fld:org_id})
	) as isexist
from dual
