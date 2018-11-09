SELECT gv.visitdate::date AS createdate, gv.code, gv.guestcode, gv.org_id 
FROM cc_guest_visit gv 
WHERE gv.visitdate >= ${fld:fdate} AND gv.visitdate <= ${fld:tdate} 
AND gv.status =3 and gv.posptid is not null and gv.posptid!='' AND gv.org_id = ${def:org} 


