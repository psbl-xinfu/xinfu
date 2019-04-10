select 
	domain_value,
	domain_text_en as domain_text_cn 
from t_domain 
where namespace = 'StartType'
--续卡方式只取”接原卡启用“
and domain_value='0'
