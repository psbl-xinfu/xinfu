select 
domain_value as commstage_value
,domain_text_cn as commstage_name
from t_domain 
where "namespace" = 'CommStage' 
and is_enabled = '1'
and domain_value not in ('8', '9')