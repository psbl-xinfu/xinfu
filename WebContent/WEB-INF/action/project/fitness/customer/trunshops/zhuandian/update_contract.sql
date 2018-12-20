update cc_contract set salemember = ${fld:mcid},org_id = ${fld:orgcode},
relatedetail=${fld:relatedetail}
where customercode=${fld:customercode} and org_id = ${def:org} and type=2 and status=2 
