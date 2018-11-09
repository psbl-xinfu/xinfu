DELETE FROM cc_contract WHERE code = ${fld:contractcode} and org_id = ${def:org} 
AND (status = 0 OR status = 1)
