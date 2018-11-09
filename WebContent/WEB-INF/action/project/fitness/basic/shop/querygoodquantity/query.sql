select 
	quantity,
	(select goods_name from cc_goods where tuid = ${fld:goodid} and org_id = ${def:org}) as goods_name,
	${fld:gptuid} as gptuid
from cc_goods_stock
where storageid = (select storageid from cc_goods_price where tuid = ${fld:gptuid} and org_id = ${def:org})
and org_id = ${def:org} and goodsid = ${fld:goodid}

