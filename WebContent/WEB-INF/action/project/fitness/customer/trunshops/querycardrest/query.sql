select
	card.cardtype as  cardtypecode,
	card.code,
	cust.org_id,
	con.code as htcode,
	cust.name,
	con.salemember,
	con.code as concode,
(case when con.contracttype=3 then '还款合同'
else (case when con.type = 0 then '办卡合同'
when con.type = 5 then '定金合同'
when con.type = 10 then '转卡合同'
when con.type=7 then '续卡合同'
 end)end) as type,--合同类型
(select name from hr_staff as staff where con.salemember=staff.userlogin)as mcname,
cardtype.name as cardname,
(case when card.status=0 then '无效'
		when card.status=1 then '正常'
		when card.status=2 then '未启用'
		when card.status=3 then '存卡中'
		when card.status=4 then '挂失中'
		when card.status=5 then '停卡中'
		when card.status=6 then '过期'
	end) as status,--状态
card.enddate,
cardtype.type as yuan

from cc_contract con 
left join cc_card card on card.contractcode=con.code
left join cc_customer cust on cust.code=con.customercode
LEFT join cc_cardtype cardtype on card.cardtype = cardtype.code
where  con.customercode = ${fld:custcode} and con.org_id = ${def:org}
and con.type != 1 and con.type != 12 and con.type != 2