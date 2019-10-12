select 1 from cc_ptprepare
where code = ${fld:ptpcode} and org_id = ${def:org}
and preparedate != {d '${def:date}'}