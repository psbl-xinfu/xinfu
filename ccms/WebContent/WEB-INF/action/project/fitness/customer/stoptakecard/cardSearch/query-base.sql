select 
	t.*,
	t.c_startdate as c_cardstartdate,
	t.c_enddate as c_cardenddate,
	st.code as vc_code,
	st.stoptype as savestop_type,--操作
	st.startdate as xc_startdate,--开始停用日期
	st.enddate as c_enddate,--截止停用日期
	st.prestopdays as i_prestopdays,--预存
	st.money as f_money,
	st.reason as vc_reason,--停卡原因
	st.remark as vc_remark,
	st.created as c_itime,
	st.createdby as vc_iuser,
	(
	case when ('${def:date}'-st.startdate)<0     then  0
	else ('${def:date}'-st.startdate) end
	) as stopcarddays,--实存
	(COALESCE((SELECT param_text::integer FROM cc_config WHERE category = 'MaxStopMonth' and org_id = ${def:org} LIMIT 1),0)*30) as daysremain,
	st.status as i_status 
from (
	select 
		card.stopdays,
		cust.org_id as vc_club,
		card.code AS vc_cardcode,
		ct.code as vc_type,
		cust.name as vc_name,
		card.customercode,
		ct.name AS vc_cardtype,
		card.status as ci_status,
		card.startdate as c_startdate,
		card.enddate as c_enddate,
		(
			select stc.code from cc_savestopcard stc where stc.cardcode = card.code 
			and stc.status != 0 
			order by stc.created desc limit 1
		) as savestopcard_code
	from cc_card card
	inner join cc_customer cust on card.customercode = cust.code and card.org_id = cust.org_id
	left join cc_cardtype ct on card.cardtype = ct.code and card.org_id = ct.org_id
	where (cust.name = ${fld:cardname} or card.code = ${fld:cardname} or exists (
			select 1 from cc_cardcode cc where card.code = cc.cardcode 
			and cc.incode = ${fld:cardname} and cc.status = 1 and cc.org_id = card.org_id
		)
	) 
	AND card.org_id = ${def:org} 
	and card.isgoon= 0
) t 
left join cc_savestopcard st on st.code = t.savestopcard_code 
