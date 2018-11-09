SELECT c1.param_value 
FROM cc_config c1 
WHERE category = 'UnitPrice' and c1.org_id = (
	case when not exists(
		select 1 from cc_config c2 where c2.org_id = ${def:org} and c2.category = c1.category 
	) then (
		select org_id from hr_org where (pid is null or pid = 0)
	) else ${def:org} end
)