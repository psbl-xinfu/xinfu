SELECT 1 FROM cc_inleft
WHERE code = ${fld:code}
AND lefttime is not null  --会员已离场
 and org_id = ${def:org}