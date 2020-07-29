select
	cc_card.code,
    cc_cardtype.name as typename,  
	(case when cc_card.status=0 then '无效'
		when cc_card.status=1 then '正常'
		when cc_card.status=2 then '未启用'
		when cc_card.status=3 then '存卡中'
		when cc_card.status=4 then '挂失中'
		when cc_card.status=5 then '停卡中'
		when cc_card.status=6 then '过期'
	end) as status
from cc_card 
left join  cc_cardtype on cc_card.cardtype=cc_cardtype.code and  cc_cardtype.org_id=${fld:menuorgid}
where 
customercode=${fld:vc_code} and cc_card.org_id=${fld:menuorgid}  and  isgoon=0 and cc_card.status!=0
