SELECT 
	domain_value,
	domain_text_cn 
FROM t_domain 
WHERE namespace = 'Age'
order by show_order asc