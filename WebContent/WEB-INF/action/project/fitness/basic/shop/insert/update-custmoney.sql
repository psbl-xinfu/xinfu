update cc_customer
set moneycash = moneycash - ${fld:paytheprice}
where code = ${fld:custcode}
and org_id = ${def:org} and ${fld:paydivgoodsinp}='f_chuzhika'
