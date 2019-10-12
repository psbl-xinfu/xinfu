insert into cc_operatelog
(
	code,
	opertype,
	relatedetail,
   	createdate,
	createtime,
	status,
	createdby,
	remark,
	org_id
)
select 
	COALESCE((SELECT memberhead FROM hr_org WHERE org_id = ${def:org}),'')||${seq:nextval@seq_cc_operatelog},			
   '41',
	concat(
		';', ${fld:customercode}, ';', ${fld:pttotalcount}, ';', ${fld:defcode}, 
		';', ${fld:pt}, ';', COALESCE(ptfee,0), ';', COALESCE(${fld:cust_name},''), ';', ${seq:currval@seq_cc_ptrest}||';'||${fld:pt}        
	),
     '${def:date}',
     '${def:time}',
     1,
     '${def:user}',
   ${fld:remark},
   ${def:org} 
from cc_ptdef 
where code = ${fld:defcode} and org_id = ${def:org}



