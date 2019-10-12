select (select name from hr_staff where userlogin = op.createdby) as vc_iuser,
	op.createdate as c_idate,c.param_text as vc_content,
	get_arr_value(op.relatedetail,0) as contract_code,
	get_arr_value(op.relatedetail,6) as card_code,
	(select customercode from cc_card where code = get_arr_value(op.relatedetail,6) and isgoon = 0 and cc_card.org_id = ${def:org} LIMIT 1) as cust_code
from cc_operatelog op
LEFT JOIN cc_config c ON c.param_value = op.opertype::varchar and op.org_id = c.org_id
where op.opertype = '49' and c.category = 'OpeCategory' and op.org_id = ${def:org}
${filter} 
and (case when ${fld:vc_all} is null then 1=1 else (get_arr_value(op.relatedetail,0)=${fld:vc_all} or get_arr_value(op.relatedetail,6) = ${fld:vc_all}) end)

UNION

select (select name from hr_staff where userlogin = op.createdby) as vc_iuser,
	op.createdate as c_idate,c.param_text as vc_content,
	op.relatedetail as contract_code,
	(select code from cc_card where customercode = (select customercode from cc_contract where code = op.relatedetail and cc_contract.org_id = ${def:org} LIMIT 1) and cc_card.org_id = ${def:org} and isgoon = 0 LIMIT 1) as card_code,
	(select customercode from cc_contract where code = op.relatedetail LIMIT 1) as cust_code
from cc_operatelog op
LEFT JOIN cc_config c ON c.param_value = op.opertype::varchar and op.org_id = c.org_id
where op.opertype = '66' and c.category = 'OpeCategory' and op.org_id = ${def:org}
${filter}
and (case when ${fld:vc_all} is null then 1=1 else (op.relatedetail=${fld:vc_all} or 
	op.relatedetail in (select code from cc_contract where customercode in (select customercode from cc_card where code = ${fld:vc_all} and org_id = ${def:org} and isgoon = 0) and org_id = ${def:org})) end)

${orderby}