
select domain_value,domain_text_cn from t_domain where "namespace" = 'communicationTarget' and is_enabled = '1'
and domain_value in ('2', '3', '4', '7')