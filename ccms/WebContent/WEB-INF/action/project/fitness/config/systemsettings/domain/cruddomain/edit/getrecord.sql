select
	tuid,
    domain_value,
    domain_text_cn,
    domain_text_en,
    remark 
from t_domain
where tuid = ${fld:id}

