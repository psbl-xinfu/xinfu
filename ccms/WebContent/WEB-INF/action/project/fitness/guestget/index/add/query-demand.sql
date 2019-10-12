SELECT 
	domain_value,
	domain_text_cn 
FROM t_domain 
WHERE namespace = 'demand' and is_enabled='1'
order by show_order asc