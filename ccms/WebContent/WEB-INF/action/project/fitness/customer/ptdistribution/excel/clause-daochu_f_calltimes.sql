 and
	(select count(1) from cc_comm comm where c.code=comm.customercode 
	and cust_type=2 and comm.org_id = c.org_id)<${fld:daochu_f_calltimes}::int
