SELECT 
	q.tuid,
	t.code AS ptrestcode,
	t.customercode,
	t.org_id,
	t.ptlevelcode,
	t.ptfee,
	t.scale,
	COALESCE(d.times,0) AS times,
	 (case when d.reatetype=1 then
(select pt from cc_customer where code=t.customercode and org_id=t.org_id)
	else t.ptid
 end)  as ptid,
	t.ptleftcount,
	(
		SELECT p.code FROM cc_ptprepare p 
		WHERE p.ptrestcode = t.code AND p.org_id = t.org_id 
		AND p.preparedate = {d '${def:date}'} AND p.status = 1 
		AND NOT EXISTS(
			SELECT 1 FROM cc_ptlog g 
			WHERE g.ptrestcode = t.code AND g.org_id = t.org_id 
			AND g.preparecode = p.code 
		) 
		ORDER BY p.preparetime LIMIT 1
	) AS preparecode 
FROM wx_qrcode q 
INNER JOIN cc_ptrest t ON t.code = ${fld:ptrestcode} AND (case when (select reatetype from cc_ptdef where code=t.ptlevelcode and org_id=t.org_id)=1 then
(select pt from cc_customer where code=t.customercode and org_id=t.org_id)
	else t.ptid
 end) = q.pk_value AND t.org_id = q.org_id 
INNER JOIN cc_ptdef d ON  t.ptlevelcode = d.code AND t.org_id = d.org_id 
INNER JOIN hr_staff f ON f.userlogin = (case when d.reatetype=1 then 
(select pt from cc_customer where code=t.customercode and org_id=t.org_id)
	else t.ptid
 end) 

WHERE ${fld:qrcode} = md5(concat(t.org_id, '###', f.user_id)) AND q.data_type = 1 
AND q.status != 0 AND q.resultcode = 0 
AND t.ptleftcount > 0 
LIMIT 1
