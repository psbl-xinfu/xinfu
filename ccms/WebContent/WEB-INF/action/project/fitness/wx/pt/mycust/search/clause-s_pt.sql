 and
 exists(
 			 	select 1 from cc_ptrest p where p.customercode=c.code
 			 	and ptenddate <=('${def:date}'::date+'${fld:s_pt} day'::interval)
 			 	and p.org_id=${def:org}
 			 	)