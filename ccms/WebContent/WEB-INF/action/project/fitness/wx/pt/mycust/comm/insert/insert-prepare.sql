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
	    ${fld:customercode},
	    1,
	    ${fld:commway}::int4,
	    ${fld:mobile},
	    ${fld:pdate},
	    ${fld:ptime},
	    1,
	    ${fld:remark},
	    '${def:user}',
	    {ts'${def:timestamp}'},
	    ${def:org}
    from dual where ${fld:commresult}='2'
)
