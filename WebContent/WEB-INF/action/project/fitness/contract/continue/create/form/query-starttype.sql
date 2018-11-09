select 
	domain_value,
	domain_text_en as domain_text_cn 
from t_domain 
where namespace = 'StartType'
