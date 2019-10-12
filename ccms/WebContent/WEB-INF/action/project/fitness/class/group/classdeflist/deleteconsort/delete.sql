delete from cc_classlist
where org_id= ${def:org}
and classcode = ${fld:cdcode}
and status !=1
and (classdate>=${fld:startdate} and classdate<=${fld:enddate}) 


