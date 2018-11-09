select 
	goods_name
from cc_goods 
where tuid = ${fld:goodsid} and org_id = ${def:org}

