update cc_goods_price set 
	storageid=${fld:storageid},
	price=${fld:price},
	staff_price=${fld:staff_price},
	remark=${fld:remark},
	updated={ts'${def:timestamp}'},
	updatedby='${def:user}'
where
	tuid = ${fld:tuid} and org_id = ${def:org}
