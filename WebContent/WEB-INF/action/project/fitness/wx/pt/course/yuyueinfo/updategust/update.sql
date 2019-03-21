UPDATE cc_ptprepare 
SET 
status=${fld:status}
where
code=${fld:code} and org_id=${def:org}