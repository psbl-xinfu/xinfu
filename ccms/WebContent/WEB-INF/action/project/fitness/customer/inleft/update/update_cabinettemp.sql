update cc_cabinettemp  
set cardcode=b.cardcode,
	customercode=b.customercode,
	type=b.type,
	cardtype=b.cardtype,
	createdby='${def:user}',
	created={ts'${def:timestamp}'},
	remark=b.remark,
	status=1 
from cc_cabinettemp b 
where b.cabinettempcode=${fld:oldcabinettempcode} 
and cc_cabinettemp.cabinettempcode=${fld:newcabinettempcode}

