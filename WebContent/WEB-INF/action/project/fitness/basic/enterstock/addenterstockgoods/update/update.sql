update cc_enter_stock_goods set 
	goodsid=${fld:goodsid},
	amount=${fld:amount},
	price=${fld:price},
	money=${fld:money},
	factmoney=${fld:factmoney},
	remark=${fld:remark}
where
	tuid = ${fld:tuid} and org_id = ${def:org}
