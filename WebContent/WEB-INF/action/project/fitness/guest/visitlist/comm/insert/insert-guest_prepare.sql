insert into cc_guest_prepare
(
    code,
    guestcode,
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
		${seq:nextval@seq_cc_guest_prepare},
	    ${fld:guestcode},
	    0,
	    ${fld:mobile},
	    ${fld:pdate},
	    ${fld:ptime},
	    ${fld:remark},
	    1,
	    ${fld:createdby},
	    {ts'${def:timestamp}'},
	    ${def:org}
    from dual where ${fld:commresult}='2'
)
