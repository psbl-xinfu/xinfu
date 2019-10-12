SELECT 1 FROM cc_contract 
WHERE code = ${fld:contractcode} and org_id = ${def:org} AND status >= 2 
