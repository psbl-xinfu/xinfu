SELECT
code,
(select name from cc_customer where code=cc_ptprepare.customercode and cc_customer.org_id=${def:org}) as pt,
preparetime,
customercode,

(
select d.ptlevelname  from  cc_ptdef d
inner join cc_ptrest t on  t.ptlevelcode=d.code and  cc_ptprepare.ptrestcode=t.code  and t.org_id=${def:org}
and d.org_id=${def:org}
limit 1 
)as ptlevelname,

(
select d.times from  cc_ptdef d
inner join cc_ptrest t on  t.ptlevelcode=d.code and  cc_ptprepare.ptrestcode=t.code  and t.org_id=${def:org}
and d.org_id=${def:org}
limit 1 
)as times,

(
select d.code from  cc_ptdef d
inner join cc_ptrest t on  t.ptlevelcode=d.code and  cc_ptprepare.ptrestcode=t.code  and t.org_id=${def:org}
and d.org_id=${def:org}
limit 1 
)as pdcode,

(
select code from cc_trainplan where ptpreparecode=cc_ptprepare.code  and cc_trainplan.org_id=${def:org}
)as traincode,

(
select status from cc_trainplan where ptpreparecode=cc_ptprepare.code and cc_trainplan.org_id=${def:org}
)as status
FROM cc_ptprepare
where preparedate::date=${fld:parpreYear}::date
and org_id=${def:org}
and status!=0
and ptid=(
	case when ${fld:ptpreparecode_record} is null or ${fld:ptpreparecode_record}='' then '${def:user}'
	else (select ptid from  cc_ptprepare where code=${fld:ptpreparecode_record} and org_id=${def:org})
	end
)
and customercode=${fld:customercode}


