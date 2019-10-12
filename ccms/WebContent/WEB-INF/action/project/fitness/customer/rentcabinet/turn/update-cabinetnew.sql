update  cc_cabinet
set status = 1
where cabinetcode=${fld:c_newcabinetcode} and org_id = ${def:org}
