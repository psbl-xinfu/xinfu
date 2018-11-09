UPDATE wx_qrcode 
SET
	resultcode = 1,
	resultmsg = '' 
WHERE tuid in (SELECT q.tuid FROM wx_qrcode q 
	INNER JOIN cc_card d ON d.code = q.pk_value AND d.isgoon = 0 AND d.org_id = q.org_id 
	INNER JOIN cc_cardtype ct on d.cardtype = ct.code and d.org_id = ct.org_id 
	WHERE ${fld:custall} = md5(concat(d.org_id, '###', d.code)) 
	AND (
		q.org_id = ${def:org} OR EXISTS(
			SELECT 1 FROM cc_cardtype ct 
			INNER JOIN cc_cardcategory cate ON ct.cardcategory = cate.code AND ct.org_id = cate.org_id 
			INNER JOIN t_union u ON cate.union_id = u.tuid 
			INNER JOIN t_union_club ub ON u.tuid = ub.union_id 
			WHERE ct.code = d.cardtype AND ct.org_id = d.org_id AND ub.club_id = ${def:org} 
		)
	) 
	AND q.data_type = 0 
	AND q.status != 0 AND q.resultcode = 0 
	AND d.status != 0 AND d.status != 6)
