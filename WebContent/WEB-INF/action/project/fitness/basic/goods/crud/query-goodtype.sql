select	
	domain_value,
	domain_text_cn
from t_domain 
where "namespace"='goodType' and is_enabled = '1' 
order by show_order asc
