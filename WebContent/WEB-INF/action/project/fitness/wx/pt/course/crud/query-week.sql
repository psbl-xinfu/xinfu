SELECT
(select name from cc_customer where code=cc_ptprepare.customercode) as name,
preparetime::time,
preparedate,
(select preparedate::date-now()::date) as num,
status
FROM cc_ptprepare
where 
preparedate::date>={d '${def:date}'}
and preparedate::date<=({ts '${def:timestamp}'}+'7 day'::interval)::date
and org_id=${def:org}
and status!=0
and ptid='${def:user}'


