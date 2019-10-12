update cc_customer
set	moneycash = (moneycash::float-${fld:paytheprice}::float)
where code = ${fld:customercode} and org_id = ${def:org}
and ${fld:paydivgoodsinp}='f_chuzhika'