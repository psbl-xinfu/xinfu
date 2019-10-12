select
	tuid,
    domain_value,
    domain_text_cn,
    domain_text_en,
    namespace,
    remark 
from t_domain
where 1=1 and is_enabled ='1' and "namespace" = ${fld:filternamespace}
order by tuid desc

