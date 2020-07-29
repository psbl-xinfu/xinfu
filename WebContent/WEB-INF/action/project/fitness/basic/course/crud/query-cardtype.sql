select
	code,
    category_name,
    union_id
from cc_cardcategory
where  status != 0 
and org_id=${def:org}