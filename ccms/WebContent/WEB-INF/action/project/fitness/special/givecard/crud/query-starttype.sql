SELECT 
	domain_value, 
	domain_text_cn 
FROM t_domain 
WHERE namespace = 'StartType' AND is_enabled = '1'
order by show_order asc
