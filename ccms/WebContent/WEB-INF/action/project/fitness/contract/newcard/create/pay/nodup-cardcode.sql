SELECT 1 FROM cc_card WHERE code = ${fld:cardcode} AND org_id = ${def:org} 
AND ${fld:cardcode} IS NOT NULL AND ${fld:cardcode} != ''