SELECT 1 FROM cc_cardcode 
WHERE incode = ${fld:incode} AND cardcode != ${fld:cardcode} AND org_id = ${def:org} 
AND ${fld:cardcode} IS NOT NULL AND ${fld:cardcode} != '' 
AND ${fld:incode} IS NOT NULL AND ${fld:incode} != ''
