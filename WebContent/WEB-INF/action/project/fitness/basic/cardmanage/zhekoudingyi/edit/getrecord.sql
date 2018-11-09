select
(mealdiscount*100.00)::numeric(10,2) as a ,--点餐折扣定义（100
(drinkdiscount*100.00)::numeric(10,2) as b,--饮品折扣定义（100
(jsdiscount*100.00)::numeric(10,2) as c,--健身折扣定义（100
(swimdiscount*100.00)::numeric(10,2) as d,--游泳折扣定义（100
(singlediscount*100.00)::numeric(10,2) as e,--单词消费折扣定义（100
(classdiscount*100.00)::numeric(10,2) as f--
from cc_cardtype
where 
	code = ${fld:in_vc_code} and org_id = ${def:org}
