select 
	(SELECT config.param_value FROM cc_config config WHERE config.category = 'Wish' 
	  	and config.org_id = (case when 
		not exists(select 1 from cc_config c where c.org_id = ${def:org} and c.category=config.category) 
		then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end)) as remak,
	card.code as vc_code,--卡号
	cab.type as i_type,
	ct.name as cardtype,--卡类型
	inleft.nowcount as old_count,--原有次数
	${fld:nowcount} as use_count,--扣次
	inleft.nowcount - ${fld:nowcount}::int as new_count,--剩余次
    (select inuser from cc_inleft where cc_inleft.cardcode=card.code and indate= '${def:date}' and org_id = ${def:org} order by intime desc limit 1) as vcuser,--操作人
   	(select indate  from cc_inleft  where cc_inleft.cardcode=card.code  and indate= '${def:date}' and org_id = ${def:org} order by intime desc  limit 1) as pay_date,--操作时间
    (select intime  from cc_inleft  where cc_inleft.cardcode=card.code  and indate= '${def:date}' and org_id = ${def:org} order by intime desc  limit 1) as pay_time,--操作时间
   	(SELECT org_name FROM hr_org WHERE org_id = ${def:org}) as vc_club,
	(case cab.type when 0 then '健身' when 1 then'游泳' when 2 then '洗浴' end) as vc_type --类型
from  cc_inleft inleft
LEFT JOIN cc_card card on inleft.cardcode=card.code and inleft.customercode = card.customercode
LEFT JOIN cc_cabinettemp cab on cab.cardcode=card.code and cab.customercode = card.customercode
LEFT JOIN cc_cardtype ct on ct.code=card.cardtype  and ct.org_id = card.org_id
WHERE
inleft.code=${fld:inleftcode}
  and	inleft.cardcode = ${fld:pk_value} and card.isgoon =0 and card.org_id = ${fld:org_id}
	AND
	inleft.indate= '${def:date}'   
 order by intime  limit 1
