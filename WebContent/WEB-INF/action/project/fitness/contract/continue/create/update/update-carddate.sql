UPDATE cc_card
SET 
	moneyleft = (COALESCE(moneyleft,0.00) + (${fld:normalmoney} - ${fld:factmoney})) 
	,moneycash = (COALESCE(moneycash,0.00) + (
		select COALESCE(e.moneyleft,0.00) from cc_cardtype e where e.code = (
			SELECT get_arr_value(t.relatedetail, 2) FROM cc_contract t WHERE t.code = ${fld:contractcode} AND t.org_id = ${def:org} LIMIT 1
		) and e.org_id = ${def:org}
	))
WHERE code = (
	SELECT t.customercode FROM cc_contract t 
	WHERE t.code = ${fld:contractcode} AND t.org_id = ${def:org} LIMIT 1
) AND org_id = ${def:org}
