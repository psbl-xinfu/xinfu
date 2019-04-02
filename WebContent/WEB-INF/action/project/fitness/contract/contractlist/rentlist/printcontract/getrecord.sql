select
	t.code,
	t.normalmoney,--应收
	t.factmoney,--实收
	t.contracttype
from cc_contract t
where t.code = ${fld:contractcode}
and t.org_id = ${def:org}