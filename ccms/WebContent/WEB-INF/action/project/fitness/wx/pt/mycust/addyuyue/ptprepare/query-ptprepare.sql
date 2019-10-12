select count(1) as ptprepare from dual where (
SELECT  (case when pf.reatetype=1 and cust.pt is null then 0 else 1 end)
FROM cc_customer cust
left join cc_ptrest pt on cust.code=pt.customercode
left join cc_ptdef pf on pt.ptlevelcode=pf.code
WHERE  pt.code = ${fld:ptrestcode}
 and cust.org_id = ${def:org} )<1