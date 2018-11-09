select 
	concat('<input type="checkbox" name="enterstockgoodslist" value="', tuid, '" "/>') AS checklink,
	(select goods_name from cc_goods where tuid = goodsid and org_id = ${def:org}) as goods_name,
	amount,
	price,
	money,
	factmoney
from cc_enter_stock_goods
where enter_stock_id = ${fld:searchenterstockid} and org_id = ${def:org}
${filter}
${orderby}
