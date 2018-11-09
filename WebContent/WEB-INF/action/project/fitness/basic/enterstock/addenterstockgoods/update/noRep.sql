select 1 from cc_enter_stock_goods
where goodsid = ${fld:goodsid} and enter_stock_id = ${fld:enterstockid}
and tuid !=${fld:tuid} and org_id = ${def:org}
