 and
	(select count(1) from cc_comm comm where r.code=comm.customercode 
	and cust_type=1 and comm.org_id = r.org_id)<${fld:daochu_f_calltimes}::int
