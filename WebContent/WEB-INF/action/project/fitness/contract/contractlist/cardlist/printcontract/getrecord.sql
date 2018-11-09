select
	t.code,
	t.normalmoney,--应收
	t.factmoney,--实收
	t.contracttype,
	dt.type
from cc_contract t
LEFT JOIN cc_card d ON get_arr_value(t.relatedetail,1) = d.code AND d.isgoon = 0 and d.status != 0 and t.org_id = d.org_id
LEFT JOIN cc_cardtype dt ON d.cardtype = dt.code and d.org_id = dt.org_id
where t.code = ${fld:contractcode}
and t.org_id = ${def:org}