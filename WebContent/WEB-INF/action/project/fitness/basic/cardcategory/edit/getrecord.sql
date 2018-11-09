select	
    code as vc_code,
    category_name as vc_name,
    showorder as i_priority,
    remark as vc_remark,
    union_id 
from 
	cc_cardcategory
where 
	code = ${fld:id} 
