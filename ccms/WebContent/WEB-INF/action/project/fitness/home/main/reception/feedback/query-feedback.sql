select 
	fb.tuid,
	(select t.tuid from t_attachment_files t where t.pk_value = cust.code and t.table_code = 'cc_customer' and t.org_id= ${def:org} order by t.tuid desc limit 1) as imgid,
	(case when fb.isanonymous=1 then '匿名' else (case when cust.name is null or cust.name='' then '未知' else cust.name end) end) as name,
	(case when fb.isanonymous=1 then '匿名' else (case when cust.mobile is null or cust.mobile='' then '未知' else cust.mobile end) end) as mobile,
	ff.created,
	ff.updated,
	ff.status,
	fb.fbremark
from cc_feedback_follow ff
left join cc_feedback fb on fb.tuid = ff.feedback_id and ff.org_id = fb.org_id
left join cc_customer cust on fb.customercode = cust.code and fb.org_id = cust.org_id
where ff.status = 1 and ff.org_id = ${def:org} 
and ff.followstaff = '${def:user}'

union

select 
	fb.tuid,
	(select t.tuid from t_attachment_files t where t.pk_value = cust.code and t.table_code = 'cc_customer' and t.org_id= ${def:org} order by t.tuid desc limit 1) as imgid,
	(case when fb.isanonymous=1 then '匿名' else (case when cust.name is null or cust.name='' then '未知' else cust.name end) end) as name,
	(case when fb.isanonymous=1 then '匿名' else (case when cust.mobile is null or cust.mobile='' then '未知' else cust.mobile end) end) as mobile,
	ff.created,
	ff.updated,
	ff.status,
	fb.fbremark
from cc_feedback_follow ff
left join cc_feedback fb on fb.tuid = ff.feedback_id and ff.org_id = fb.org_id
left join cc_customer cust on fb.customercode = cust.code and fb.org_id = cust.org_id
where ff.status in (2, 3, 4) and ff.org_id = ${def:org} and ff.updated::date = '${def:date}'::date
and ff.followstaff = '${def:user}'

order by created desc