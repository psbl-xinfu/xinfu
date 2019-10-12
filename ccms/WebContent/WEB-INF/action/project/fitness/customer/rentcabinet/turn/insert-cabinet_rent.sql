insert into  cc_cabinet_rent 
(
	tuid,
	customercode,
	cabinetcode,
	startdate,
	enddate,
	contractcode,
	pid,
	createdby,
	created,
	cabinetid,
	remark,
	org_id,
	deposit
)

select
	${seq:nextval@seq_cc_cabinet_rent},
	customercode,
	${fld:c_newcabinetcode},
	{ts'${def:timestamp}'},
	enddate,
	contractcode,
	tuid,
	'${def:user}',
	{ts'${def:timestamp}'},
	${fld:c_cabinettuid},
	${fld:c_remark},
	${def:org},
	deposit
from
cc_cabinet_rent
where tuid = ${fld:cabinetrentid}::int and org_id = ${def:org}