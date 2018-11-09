select 
(SELECT
  cnfg_id as wish_id,
	vc_content as wish
FROM
	e_cnfg
WHERE
	vc_category = 'Wish') as remak,
vc_code,--卡号
e_cabinettemp.i_type,
e_cardtype.vc_name as card_type,--卡类型
e_cardtype.i_count as old_count,--原有次数
1 as use_count,--扣次
e_cardtype.i_count -1 as new_count,--剩余次
    (select vc_inuser  from e_inleft  where   e_inleft.vc_cardcode=e_card.vc_code  and    c_idate= '${def:date}'     order by c_initime desc limit 1)      as vc_user,--操作人
   (select c_idate  from e_inleft  where   e_inleft.vc_cardcode=e_card.vc_code  and    c_idate= '${def:date}'     order by c_initime desc  limit 1)       as pay_date,--操作时间
    (select pay_time  from e_inleft  where   e_inleft.vc_cardcode=e_card.vc_code  and    c_idate= '${def:date}'     order by c_initime desc  limit 1)       as pay_time,--操作时间
   (SELECT tenantry_name FROM t_tenantry WHERE tenantry_id = ${def:tenantry}) as vc_club,
(case  i_type when 0 then '健身' when 1 then'游泳' when 2  then '洗浴'  end   ) as vc_type --类型
from e_card
LEFT JOIN  e_cabinettemp on e_cabinettemp.vc_cardcode=e_card.vc_code
LEFT JOIN  e_cardtype on   e_cardtype.vc_code=e_card.vc_cardtype 
LEFT JOIN  e_inleft    on   e_inleft.vc_cardcode=e_card.vc_code
WHERE
	e_card.vc_code = ${fld:vc_code}
	AND
e_inleft.c_idate= '${def:date}'   
and  e_inleft.vc_type='本人入场'
 order by c_initime  limit 1
	
