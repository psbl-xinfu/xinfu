--查询会员保护期内跟进次数小于设置的次数的人  zyb

WITH cnfg AS (
	SELECT  
		COALESCE((
			SELECT c1.param_value FROM cc_config c1 
			WHERE category = 'CustMaxFPCount' AND c1.org_id = (
				case when NOT EXISTS(SELECT 1 FROM cc_config c2 WHERE c2.org_id = ${def:org}  AND c2.category = c1.category) 
				THEN (SELECT org_id FROM hr_org WHERE (pid IS NULL OR pid = 0)) 
				ELSE ${def:org}  END
			) LIMIT 1
		),'30')::INTEGER as maxcount
	FROM dual 
),
 cnfgmax AS (
	SELECT  
		COALESCE((
			SELECT c1.param_value FROM cc_config c1 
			WHERE category = 'MembershipProtectionPeriod' AND c1.org_id = (
				case when NOT EXISTS(SELECT 1 FROM cc_config c2 WHERE c2.org_id = ${def:org}  AND c2.category = c1.category) 
				THEN (SELECT org_id FROM hr_org WHERE (pid IS NULL OR pid = 0)) 
				ELSE ${def:org}  END
			) LIMIT 1
		),'30')::INTEGER as maxday
				 
	FROM dual
) 
SELECT 
	r.code AS customercode, NULL::VARCHAR AS guestcode, r.org_id, r.mc 
FROM cc_customer r 
WHERE r.org_id = ${def:org}  
AND (case when (SELECT cg.maxcount FROM cnfg cg)=0 then null=null else
(SELECT cg.maxcount FROM cnfg cg) > (
SELECT count(1) from cc_comm cm where  not EXISTS (
select 1 from cc_mcchange where cm.customercode=customercode and cm.org_id=org_id
 ) and r.code=cm.customercode and r.org_id=cm.org_id and cm.cust_type=1 GROUP BY cm.customercode
)end)
 AND r.status = 1 
and
({ts '${def:timestamp}'} - (((select cfx.maxday from cnfgmax cfx)||'day')::interval)) < r.created
union

SELECT 
	t.code AS customercode, NULL::VARCHAR AS guestcode, t.org_id, t.mc 
FROM cc_customer t 
WHERE t.org_id = ${def:org} 
AND (case when (SELECT cg.maxcount FROM cnfg cg)=0 then null=null else
(SELECT cg.maxcount FROM cnfg cg) >(
select count(1) from cc_comm cm 
where  cm.pk_value in (select code from (
		select max(code)as code,customercode,max(created) as created from cc_mcchange where ({ts '${def:timestamp}'}::TIMESTAMP - (((select cfx.maxday from cnfgmax cfx)||'day')::interval))<created GROUP BY customercode HAVING customercode is not null
	) as me) 
and t.code=cm.customercode and t.org_id=cm.org_id and cm.cust_type=1 GROUP BY cm.pk_value
)end)
 AND t.status = 1 
