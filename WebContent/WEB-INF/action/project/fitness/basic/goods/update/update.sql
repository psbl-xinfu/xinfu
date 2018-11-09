update cc_goods set 
	goods_name=${fld:goods_name},
	fastcode=${fld:fastcode},
	goods_type=${fld:goods_type},
	standard=${fld:standard},
	unit=${fld:unit},
	buyprice=${fld:buyprice},
	isgift=${fld:isgift},
	remark=${fld:remark},
	updated={ts'${def:timestamp}'},
	updatedby='${def:user}'
where
	tuid = ${fld:tuid} and org_id = ${def:org}
