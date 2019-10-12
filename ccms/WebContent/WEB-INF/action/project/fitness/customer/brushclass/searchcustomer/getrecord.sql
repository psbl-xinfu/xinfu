select
	code,
	name,
	mobile,
	(select t.tuid from t_attachment_files t where t.pk_value = c.code and t.table_code = 'cc_customer' and t.org_id= ${def:org} order by t.tuid desc limit 1) as imgid,
	(case when sex=0 then '女' when sex=1 then '男' else '未知' end) as sex,
	(select name from hr_staff where userlogin = pt) as pt
from cc_customer c 
where code = ${fld:custall}
and org_id = ${def:org}