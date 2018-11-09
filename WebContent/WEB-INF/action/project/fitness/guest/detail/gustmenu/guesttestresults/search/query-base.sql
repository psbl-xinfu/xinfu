SELECT 
	tr.code,
	guest.code as custcode,
	guest.name,
	guest.mobile,
    concat('<input type="checkbox" class="testresult" name="testresult" value="', tr.code, '">') as application_id,
	tr.code,
	tr.created,
	(select name from hr_staff where userlogin = tr.createdby) AS pt_name,
	concat(p.preparedate, ' ', p.preparetime) as preparedate,
	tr.remark
FROM cc_testresult tr
left join cc_guest guest on tr.guestcode = guest.code and tr.org_id = guest.org_id
left join cc_ptprepare p on tr.ptpreparecode = p.code and tr.org_id = p.org_id
LEFT JOIN cc_ptrest r ON p.ptrestcode = r.code and p.org_id = r.org_id
WHERE tr.status = 1  and tr.org_id = ${def:org}
and guest.code = ${fld:guest_code}

union

SELECT 
	tr.code,
	cust.code as custcode,
	cust.name,
	cust.mobile,
    concat('<input type="checkbox" class="testresult" name="testresult" value="', tr.code, '">') as application_id,
	tr.code,
	tr.created,
	(select name from hr_staff where userlogin = tr.createdby) AS pt_name,
	concat(p.preparedate, ' ', p.preparetime) as preparedate,
	tr.remark
FROM cc_testresult tr
left join cc_customer cust on tr.customercode = cust.code and tr.org_id = cust.org_id
left join cc_ptprepare p on tr.ptpreparecode = p.code and tr.org_id = p.org_id
LEFT JOIN cc_ptrest r ON p.ptrestcode = r.code and p.org_id = r.org_id
WHERE tr.status = 1  and tr.org_id = ${def:org}
and cust.code = ${fld:custcode}

order by created desc
