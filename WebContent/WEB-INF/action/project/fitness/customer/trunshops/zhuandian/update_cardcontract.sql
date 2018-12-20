update cc_contract set salemember = ${fld:mcid},org_id = ${fld:orgcode}
where customercode=${fld:customercode} and org_id = ${def:org} and 
type != 1 and type != 12 and type != 2