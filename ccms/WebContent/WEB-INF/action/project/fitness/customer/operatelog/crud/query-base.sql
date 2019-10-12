select param_value AS domain_value, param_text AS domain_text_cn
from cc_config where category ='OpeCategory' and org_id = ${def:org}
