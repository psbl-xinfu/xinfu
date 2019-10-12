and
(case
   	when ${fld:s_genjin} = 0 then 
 		not exists(
 		select 1 from cc_comm comm where comm.customercode = c.code
	and comm.org_id = ${def:org}
 		)
else
	 exists(
 		select 1 from cc_comm comm where comm.customercode = c.code
	and comm.org_id = ${def:org}
 		)
 end)