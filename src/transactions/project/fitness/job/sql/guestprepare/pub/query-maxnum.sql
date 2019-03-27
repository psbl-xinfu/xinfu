--会员跟进次数zyb

WITH cnfg AS (
	SELECT  
		COALESCE((
			SELECT c1.param_value FROM cc_config c1 
			WHERE category = 'CustMaxFPCount' AND c1.org_id = (
				case when NOT EXISTS(SELECT 1 FROM cc_config c2 WHERE c2.org_id = ${fld:org_id} AND c2.category = c1.category) 
				THEN (SELECT org_id FROM hr_org WHERE (pid IS NULL OR pid = 0)) 
				ELSE ${fld:org_id} END
			) LIMIT 1
		),'30')::INTEGER as maxfpcount
	FROM dual 
) 
SELECT 
	NULL::VARCHAR  guestcode,  r.code AS customercode, r.org_id, r.mc 
FROM cc_customer r 
WHERE r.org_id = ${fld:org_id} 
AND (case when (SELECT cg.maxfpcount FROM cnfg cg)=0 then null=null else
(SELECT cg.maxfpcount FROM cnfg cg) < (
SELECT count(1) from cc_comm cm where  not EXISTS (
select 1 from cc_mcchange where cm.customercode=customercode and cm.org_id=org_id
 ) and r.code=cm.customercode and r.org_id=cm.org_id and cm.cust_type=1 GROUP BY cm.customercode
)end)
 AND r.status = 1 

UNION

SELECT 
	NULL::VARCHAR  guestcode,  t.code AS customercode, t.org_id, t.mc 
FROM cc_customer t 
WHERE t.org_id = ${fld:org_id} 
AND (case when (SELECT cg.maxfpcount FROM cnfg cg)=0 then null=null else
(SELECT cg.maxfpcount FROM cnfg cg) <(
select count(1) from cc_comm cm 
where  cm.pk_value in (select code from (
		select max(code)as code,customercode,max(created) as created from cc_mcchange GROUP BY customercode HAVING customercode is not null
	) as me) 
and t.code=cm.customercode and t.org_id=cm.org_id and cm.cust_type=1 GROUP BY cm.pk_value
)end)
 AND t.status = 1 




