insert into cc_ptrest
(
	code,  
	customercode,   
	org_id,
	ptlevelcode, 
	pttotalcount, 
	ptleftcount,   
	ptnormalmoney,
	ptmoney,
	ptfactfee,  
	ptfee,  
	scale,
	ptid,
	createdby,  
	created,
	pttype,
	ptenddate
)
select
	${seq:nextval@seq_cc_ptrest},
	${fld:customercode},
	${def:org},  
	${fld:defcode},  
	${fld:pttotalcount},	
	${fld:pttotalcount},	
	${fld:pttotalcount}*ptfee,     
	${fld:price},  
	ptfee,
	ptfee, 
	COALESCE(${fld:scale}, 0),
	(case when reatetype =1 then null else ${fld:pt} end) as bin,  
	'${def:user}',
	{ts'${def:timestamp}'},
	5,
	${fld:ptenddate}
from cc_ptdef 
where code = ${fld:defcode} and org_id = ${def:org}

