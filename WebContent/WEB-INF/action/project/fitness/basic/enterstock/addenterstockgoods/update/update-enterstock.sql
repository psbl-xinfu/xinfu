update cc_enter_stock
set normalmoney = (select sum(money) from cc_enter_stock_goods where enter_stock_id = ${fld:enterstockid} and org_id = ${def:org}),
	factmoney = (select sum(factmoney) from cc_enter_stock_goods where enter_stock_id = ${fld:enterstockid} and org_id = ${def:org})
where tuid = ${fld:enterstockid} and org_id = ${def:org}
