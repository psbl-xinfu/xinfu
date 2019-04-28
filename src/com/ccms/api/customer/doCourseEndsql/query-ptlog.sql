SELECT code,quittingtime from cc_ptlog 
where preparecode=${fld:reservationID}  
and ptid=${fld:employeeId} 
and customercode=${fld:userId} 
and org_id=${fld:org}
