UPDATE cc_guest_prepare 
SET 
preparedate=${fld:date},
preparetime=${fld:time}
where
code=${fld:commcode} and org_id = ${def:org}