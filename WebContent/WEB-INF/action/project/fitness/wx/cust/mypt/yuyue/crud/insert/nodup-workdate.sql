with ptdata as (
	select (
				select concat(${fld:hour}, ':', ${fld:minute})::time + concat(d.times,' minutes')::interval 
				from cc_ptrest t 
				inner join cc_ptdef d on t.ptlevelcode = d.code and t.org_id = d.org_id 
				where t.code = ${fld:ptcode}and t.org_id = '${def:org}'
		) as endtime
	from dual 
) 
select 1 from dual 
where exists(
	select 1 from cc_ptprepare p 
	where p.preparedate =${fld:pdate} ::date and p.ptid = (select ptid from cc_ptrest where code = ${fld:ptcode} and org_id = ${def:org}) 
	and (
		(p.preparetime > concat(${fld:hour}, ':', ${fld:minute})::time and p.preparetime <= (select endtime from ptdata) and p.endtime >= (select endtime from ptdata))
		or (p.preparetime <= concat(${fld:hour}, ':', ${fld:minute})::time and p.endtime >= (select endtime from ptdata))
		or (p.preparetime < (select endtime from ptdata) and p.preparetime <=concat(${fld:hour}, ':', ${fld:minute})::time and p.endtime >= concat(${fld:hour}, ':', ${fld:minute})::time)
	)
	and p.status!=0
)


