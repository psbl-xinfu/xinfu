select 
domain_value as commtarget_value
,domain_text_cn as commtarget_name
from t_domain 
where "namespace" = 'communicationTarget' 
and is_enabled = '1'
and domain_value not in ('8', '9')