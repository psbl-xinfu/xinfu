SELECT 1 FROM cc_inleft
WHERE code = ${fld:code}
AND cabinettempcode !=''
 and org_id = ${def:org}