select 
	t.code,
	concat('<input type="checkbox" class="trainplan" name="trainplan" value="', t.code, '" code="', t.ptpreparecode, '" code1="', t.status, '">') as application_id,
	cust.code as cust_code,
	cust.name as cust_name,
	cust.mobile,
	(select name from hr_staff where userlogin = t.ptid) as staff_name,
	concat(p.preparedate, ' ', p.preparetime) as preparedate,
	t.created,
	(case when t.status=1 then '正常' else '已执行' end) as status
from cc_trainplan t
left join cc_customer cust on t.customercode = cust.code and t.org_id = cust.org_id
left join cc_ptprepare p on t.ptpreparecode = p.code and t.org_id = p.org_id
LEFT JOIN cc_ptrest r ON p.ptrestcode = r.code and p.org_id = r.org_id
where t.org_id = ${def:org} and t.status !=0
and cust.code = ${fld:cust_code}
order by t.created desc