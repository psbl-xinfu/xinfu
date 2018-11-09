update cc_goods_stock
set quantity = quantity - ${fld:goodsnum},
	totalprice = (totalprice-((totalprice/quantity)*${fld:goodsnum}))
where storageid = (select storageid from cc_goods_price where tuid = ${fld:gptuid} and org_id = ${def:org}) 
and goodsid = ${fld:goodid}
and org_id = ${def:org}