select
	card.code,
	cust.name,
	cust.mobile,
	pr.pttotalcount::int,--私教课总节数
	pr.ptleftcount::int,--私教课剩余节数
	(case when con.type = 0 then card.enddate
when con.type = 5 then card.enddate
when con.type = 10 then card.enddate
	when con.type = 2  then pr.ptenddate end) as enddate,--结束日期
(case when con.type = 0 then cardtype.name
when con.type = 5 then cardtype.name
when con.type = 10 then cardtype.name
	when con.type = 2  then pd.ptlevelname end) as type,--卡和私教类型
(case when con.type = 0 then (case when card.status=0 then '无效' when card.status=1 then '正常' when card.status=2 then '未启用'
		  when card.status=3 then '存卡中' when card.status=4 then '挂失中' when card.status=5 then '停卡中'
		  when card.status=6 then '过期' end) 
when con.type = 5 then (case when card.status=0 then '无效' when card.status=1 then '正常' when card.status=2 then '未启用'
		  when card.status=3 then '存卡中' when card.status=4 then '挂失中' when card.status=5 then '停卡中'
		  when card.status=6 then '过期' end)
when con.type = 10 then (case when card.status=0 then '无效' when card.status=1 then '正常' when card.status=2 then '未启用'
		  when card.status=3 then '存卡中' when card.status=4 then '挂失中' when card.status=5 then '停卡中'
		  when card.status=6 then '过期' end)
when con.type = 2 then (case when pr.ptenddate::date<'${def:date}'::date then '已过期' else '正常' end)
end)
as status,--状态
(select name from hr_staff where userlogin = pr.ptid and org_id = ${def:org}) as ptname,--私教	
(case when pr.pttype=1 then '新买课'
	 	when pr.pttype=3 then '续课'
	  	when pr.pttype=4 then '转课' end) as pttype--来源
from cc_contract con 
left join cc_card card on card.contractcode=con.code
left join cc_customer cust on cust.code=con.customercode
LEFT join cc_cardtype cardtype on card.cardtype = cardtype.code
left JOIN cc_ptrest pr on pr.contractcode=con.code
left join cc_ptdef pd on pr.ptlevelcode = pd.code and pr.org_id = pd.org_id
where  con.customercode = ${fld:custcode} and con.org_id = ${def:org}
and con.type != 7 and con.type != 10 and con.contracttype!=3