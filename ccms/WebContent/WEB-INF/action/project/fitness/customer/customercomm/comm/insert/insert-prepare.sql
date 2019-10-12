insert into cc_prepare
(
    code,
    customercode,
    preparetype,
    contacttype,
    contactphone,
    preparedate,
    preparetime,
    remark,
    status,
	createdby,
	created,
	org_id
)
 
(
	select 
		${seq:nextval@seq_cc_prepare},
	    ${fld:customercode},
	    0,
	    1,
	    ${fld:mobile},
	    ${fld:pdate},
	    ${fld:ptime},
	    ${fld:remark},
	    1,
	    ${fld:createdby},
	    {ts'${def:timestamp}'},
	    ${def:org}
    from dual where ${fld:commresult}='2' and ${fld:cust_type}='1'
)
