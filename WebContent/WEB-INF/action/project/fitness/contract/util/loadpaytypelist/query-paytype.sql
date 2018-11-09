SELECT tuid, param_value, param_text, status /** 1已启用，0已禁用 */ 
FROM cc_config c1 
WHERE category = 'OtherPayWay' AND org_id = (
	case when not exists(
		select 1 from cc_config c2 where c2.org_id = ${def:org} and c2.category = c1.category 
	) then (
		select org_id from hr_org where (pid is null or pid = 0)
	) else ${def:org} end
) 
ORDER BY tuid
