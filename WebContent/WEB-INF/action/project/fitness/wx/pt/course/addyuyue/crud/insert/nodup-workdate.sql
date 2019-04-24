
with ptdata as (
				select (${fld:preparetime}::time + concat(d.times,' minutes')::interval) as endtime,
	t.ptlevelcode,d.isgroup,t.ptid,t.customercode
				from cc_ptrest t 
				inner join cc_ptdef d on t.ptlevelcode = d.code and t.org_id = d.org_id 
				where t.code = ${fld:ptrestcode} and t.org_id = '${def:org}'
) 
select 1 from dual 
where exists(
	select 1 from cc_ptprepare p
	LEFT JOIN cc_ptrest pr on p.ptrestcode=pr.code
	left join cc_ptdef pd on pr.ptlevelcode=pd.code 
	where p.preparedate =${fld:preparedate} ::date and p.ptid = 
(case when 
	pd.reatetype=1 then (select pt from cc_customer WHERE code=p.customercode and org_id = ${def:org})
	else pr.ptid 
end)  and p.org_id = ${def:org}

	and p.status!=0
and
(
		(p.preparetime >${fld:preparetime}::time and p.preparetime <= (select endtime from ptdata) and p.endtime >= (select endtime from ptdata))
		or (p.preparetime <= ${fld:preparetime}::time and p.endtime >= (select endtime from ptdata))
		or (p.preparetime < (select endtime from ptdata) and p.preparetime <=${fld:preparetime}::time and p.endtime >= ${fld:preparetime}::time)
	) and
(case when pd.isgroup=1 
			then 
					(case when  pd.code=(select ptlevelcode from ptdata) and p.ptid=(case when (select ptid from ptdata) is null then (select pt from cc_customer where code=(select customercode from ptdata) and org_id= ${def:org}) 
										else (select ptid from ptdata)
										end) 
									and p.customercode!=(select customercode from ptdata) then null=NULL
									when p.customercode=(select customercode from ptdata) then 1=1
									when p.ptid=(case when (select ptid from ptdata) is null then (select pt from cc_customer where code=(select customercode from ptdata) and org_id= ${def:org}) 
										else (select ptid from ptdata)
										end) and  pd.code!=(select ptlevelcode from ptdata) then 1=1
									else null=null
					 end)
			
	 when  (p.ptid=(case when (select ptid from ptdata) is null then (select pt from cc_customer where code=(select customercode from ptdata) and org_id= ${def:org}) 
										else (select ptid from ptdata)
										end) or p.customercode=(select customercode from ptdata)) then 1=1

	end)
)

