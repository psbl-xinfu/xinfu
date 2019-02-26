--如果不是通电卡也能刷卡就需要改这一部分
select
	card.code,
	card.nowcount,
	(case when card.status=0 then '无效'
		  when card.status=1 then '正常'
		  when card.status=2 then '未启用'
		  when card.status=3 then '存卡中'
		  when card.status=4 then '挂失中'
		  when card.status=5 then '停卡中'
		  when card.status=6 then '过期'
	end) as status,
	(select type from cc_cardtype ct where ct.code = card.cardtype and ct.org_id = ${fld:unionorgid}) as type,
	(select ct.name from cc_cardtype ct where ct.code = card.cardtype and ct.org_id = ${fld:unionorgid}) as cardtype_name,
	concat(card.enddate, '') as carddate,
	(select org_name from hr_org where org_id = ${fld:unionorgid}) as org_name,
	(select (case when lefttime is null then '1' else '2' end)
		from cc_inleft where org_id = ${fld:unionorgid} and indate = {d '${def:date}'} and cardcode = card.code order by intime desc LIMIT 1) as entrancetype,
	card.cardtype,
	(case when ((card.status = 1 and card.startdate<={d '${def:date}'} and card.enddate>={d '${def:date}'}) or (card.status = 2 and starttype=1)) then '1' else '2' end) as cardstatus,
	card.org_id
from cc_customer cust
inner join (select c.* from cc_card  c
LEFT JOIN cc_cardtype ctype on c.cardtype=ctype.code
LEFT JOIN cc_cardcategory cgory on ctype.cardcategory=cgory.code
left join t_union cunion on cgory.union_id=cunion.tuid
where c.customercode=${fld:custall} and  (case when ${fld:unionorgid}=${def:org} then c.org_id=${def:org}
 else cunion.tuid is not NULL
 end)
) card on card.customercode = cust.code and cust.org_id = card.org_id
where (case when ${fld:cardcode} is null then cust.code = ${fld:custall} else card.code = ${fld:cardcode} end)
and cust.org_id = ${fld:unionorgid} and card.isgoon = 0 --and card.status in (1, 2, 4, 5)  
--and card.startdate<={d '${def:date}'} and card.enddate>={d '${def:date}'}

