select 
	fb.tuid,
	ff.status,
	(case when fb.isanonymous=1 then '匿名' else (case when cust.name is null or cust.name='' then '未知' else cust.name end) end) as name,
	(case when fb.isanonymous=1 then '匿名' else (case when cust.mobile is null or cust.mobile='' then '未知' else cust.mobile end) end) as mobile,
	fb.customercode
from cc_feedback_follow ff
left join cc_feedback fb on ff.feedback_id = fb.tuid and ff.org_id = fb.org_id
left join cc_customer cust on fb.customercode = cust.code and fb.org_id = cust.org_id
where ff.feedback_id = ${fld:tuid} and ff.org_id = ${def:org}
order by ff.created desc LIMIT 1
