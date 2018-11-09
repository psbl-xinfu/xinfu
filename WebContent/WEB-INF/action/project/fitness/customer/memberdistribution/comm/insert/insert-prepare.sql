insert into cc_prepare
(
    code,
    customercode,
    preparetype,
    contacttype,
    contactphone,
    preparedate,
    preparetime,
    status,
    remark,
	createdby,
	created,
	org_id
)
 
(
	select 
		${seq:nextval@seq_cc_prepare},
	    ${fld:custode},
	    1,
	    0,
	    ${fld:mobile},
	    ${fld:pdate},
	    ${fld:ptime},
	    1,
	    ${fld:remark},
	    ${fld:createdby},
	    {ts'${def:timestamp}'},
	    ${def:org}
    from dual where ${fld:commresult}='2'
)
