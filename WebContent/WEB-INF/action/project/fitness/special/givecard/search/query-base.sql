select 
	concat('<input type="radio" class="giftcard" name="giftcard" value="', card.code, '" code="', card.status, '">') as application_id,
  split_part(op.relatedetail, ';',2) as card_code,--卡号
  cust.code as vc_code,--会员号
  cust.name as vc_name,--会员姓名
  ct.name as card_type,--卡类型
  (case card.status when 0 then '无效'
                    when 1 then '正常'
                    when 2 then '未启用'
                    when 3 then '存卡中'
                    when 4 then '挂失中'
                    when 5 then '停卡中'
                    else '过期' end
  )as card_status,--会员卡当时状态
  card.startdate as c_startdate,--卡启用日期
  card.enddate as c_enddate,--卡截至日期
  op.createdate as c_idate,--赠卡日期
  (select name from hr_staff where userlogin=op.createdby) as vc_iuser,--赠卡人
  op.remark as vc_remark, --备注
  (SELECT param_text from cc_config WHERE category='PresentReason' and org_id = ${def:org} and tuid::varchar = split_part(op.relatedetail, ';',3)) as why
from cc_operatelog op 
inner join cc_card card on card.code = split_part(op.relatedetail, ';',2) and op.org_id = card.org_id
left join cc_customer cust on cust.code=card.customercode and cust.org_id = card.org_id
left join cc_cardtype ct on ct.code=card.cardtype and ct.org_id = card.org_id
where card.isgoon = 0 and op.opertype='20'
and op.org_id = ${def:org}
	
${filter}

${orderby}
