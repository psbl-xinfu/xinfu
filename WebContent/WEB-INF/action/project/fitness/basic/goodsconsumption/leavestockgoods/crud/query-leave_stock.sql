with paytype as (
	SELECT rowno::integer-1 AS rowno, param_text FROM (
		SELECT ROW_NUMBER() OVER() AS rowno, param_text, status FROM (
			SELECT param_text, status FROM cc_config WHERE CATEGORY = 'OtherPayWay' 
			and org_id = (case when 
				not exists(select 1 from cc_config c where c.org_id = ${def:org} and c.category=cc_config.category) 
				then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end) 
			ORDER BY tuid
		) AS t1 
	) AS t2 WHERE status = 1
) 
select
	cust.code as custcode,
	cust.name as custname,
	card.code as cardcode,
	cust.mobile,
	ls.factmoney,
	ls.normalmoney,
	(select name from hr_staff where userlogin = ls.createdby) as createdby,
	ls.created,
	cust.moneycash,
	cust.moneygift,
	(select name from hr_staff where userlogin = ls.updatedby) as updatedby,
	ls.updated,
	ls.paystatus,
	(select string_agg(param_text,';')
		from paytype where 0.00 != (case when get_arr_value(ls.pay_detail,rowno) = '' then '0.00' else get_arr_value(ls.pay_detail,rowno) end)::numeric(10,2)
	) as paydetail,
	ls.discount
from cc_leave_stock ls
left join cc_customer cust on ls.customercode = cust.code and ls.org_id = ${def:org}
left join cc_card card on ls.paycardcode = card.code and card.isgoon = 0
where
	ls.tuid=${fld:tuid} and ls.org_id = ${def:org}
