select 1 from dual where (
SELECT  (case when cust.pt is null then 0 else 1 end)
FROM cc_customer cust
left join cc_ptrest pt on cust.code=pt.customercode
WHERE  pt.code = ${fld:ptcode}
 and cust.org_id = ${def:org} )<1