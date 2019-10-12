SELECT 
	(case when domain_value::int<10 then concat('0', domain_value) else domain_value end) as domain_value, 
	domain_text_cn 
FROM t_domain 
WHERE namespace = 'Hour' AND is_enabled = '1'
order by show_order asc
