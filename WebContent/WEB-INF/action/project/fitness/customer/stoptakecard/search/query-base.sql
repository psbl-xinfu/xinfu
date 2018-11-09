select
	st.code,
	st.cardcode,
	cust.name,
	(select name from cc_cardtype where code =st.cardtype and org_id = ${def:org}) as cardtype,
	(case when stoptype=1 then '存卡'
	when stoptype=2 then '停卡' 
	when stoptype=3 then '特殊停卡' end) as vc_type,--操作
	st.startdate,
	st.enddate,
	(
		case when ('${def:date}'-st.startdate)<0     then  0
		else ('${def:date}'-st.startdate) end
	) as i_actualdays,--实存
	st.prestopdays,--预存
	(select name from hr_staff where userlogin=cust.mc) as vc_mc,
	st.money,
	st.reason,--停卡原因
	st.remark,
	st.created,
	(select name from hr_staff where userlogin=st.createdby) as createdby,
	st.cardstartdate,
	st.cardenddate,
	(select name from hr_staff where userlogin=card.createdby) as vc_iusercard,
	(case when st.stoptype=2 and st.status=1 then '停卡中'
	when st.stoptype=2 and st.status=2 then '已取卡'
	when st.stoptype=1 and st.status=1 then '存卡中' 
	when st.stoptype=1 and st.status=2 then '已开卡'
	when st.status=10 then '未付款' else '' end) as status
	,concat('<input type="radio" name="reocrd" value="' , st.code , '" code="', (
		case when (st.status=1 and money>0) then 1 else 2 end
	), '" code2="', st.status, '" />') AS radio_link ,
	(case when st.status=2 then (case when st.updatedby is null then '系统开卡' else '人工开卡' end) else '' end) as opencardway,
	(case when (st.stoptype=2 and st.status=1) then ((select (st.startdate::date + concat(st.prestopdays ,' d')::interval))::date-'${def:date}'::date)::varchar else '' end) as days
from cc_savestopcard st
inner join cc_customer cust on st.customercode=cust.code and st.org_id = cust.org_id
left join cc_card card on st.cardcode=card.code and card.isgoon = 0 and card.org_id = st.org_id
where st.status > 0 and st.stoptype is not null 
AND st.org_id = ${def:org} 
${filter}
${orderby}
