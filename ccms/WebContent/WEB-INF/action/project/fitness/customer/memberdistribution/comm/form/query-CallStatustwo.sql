
select domain_value,domain_text_cn from t_domain where "namespace" = 'CallStatus' and is_enabled = '1'
and domain_value in ('7', '8')