select 
	card.code,
	card.customercode,
	card.org_id as unionorgid,
	card.status,
	(case when card.status=0 then '无效'
		  when card.status=1 then '正常'
		  when card.status=2 then '未启用'
		  when card.status=3 then '存卡中'
		  when card.status=4 then '挂失中'
		  when card.status=5 then '停卡中'
		  when card.status=6 then '过期'
	end) as statusname,
	1 as statustype
from cc_card card
where card.isgoon = 0 
and (
	card.code in (select cardcode from cc_cardcode where incode = ${fld:custall} and org_id = ${def:org} and status = 1)
	or card.code = ${fld:custall}
	or customercode in (select code from cc_customer where name like concat('%', ${fld:custall}, '%') or mobile like concat('%', ${fld:custall}, '%'))
)
and (
	card.org_id = ${def:org} or exists(
		select 1 from cc_card c
		inner join cc_cardtype ct on c.cardtype = ct.code and c.org_id = ct.org_id 
		inner join cc_cardcategory cate on ct.cardcategory = cate.code and ct.org_id = cate.org_id 
		inner join t_union u on cate.union_id = u.tuid 
		inner join t_union_club ub on u.tuid = ub.union_id 
		where c.code = card.code and c.org_id = c.org_id and ub.club_id = ${def:org} 
		and c.isgoon = 0 
	)
)

union

SELECT 
	d.code,
	d.customercode,
	d.org_id as unionorgid,
	d.status,
	(case when d.status=0 then '无效'
		  when d.status=1 then '正常'
		  when d.status=2 then '未启用'
		  when d.status=3 then '存卡中'
		  when d.status=4 then '挂失中'
		  when d.status=5 then '停卡中'
		  when d.status=6 then '过期'
	end) as statusname,
	2 as statustype
FROM wx_qrcode q 
INNER JOIN cc_card d ON d.code = q.pk_value AND d.isgoon = 0 AND d.org_id = q.org_id 
INNER JOIN cc_cardtype ct on d.cardtype = ct.code and d.org_id = ct.org_id 
INNER JOIN cc_customer c ON c.code = d.customercode AND c.org_id = d.org_id 
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
