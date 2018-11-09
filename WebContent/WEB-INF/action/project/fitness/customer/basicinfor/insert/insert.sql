insert into cc_customer
(
    code,
    status,
    name,
    sex,
    org_id,
    birthdate,
	rank,
	email,
    idnumber,
    nation,
    hometel,
    addr,
    officetel,
	zip,
	mobile,
    contact,
    company,
    jobtype,
    illnessrec,
    hobby,
	pt,
	mc,
    guestcode,
    moneyleft,
    emcontact1,
    emcontact2,
    createdby,
	created,
	remark
)
values 
(
	${seq:nextval@seq_cc_customer},
    ${fld:i_status},
    ${fld:vc_name},
    ${fld:i_sex},
    ${fld:vc_club},
    ${fld:c_birthdate},
    ${fld:vc_rank},
    ${fld:vc_email},
    ${fld:vc_idnumber},
    ${fld:vc_nation},
    ${fld:vc_hometel},
    ${fld:vc_addr},
    ${fld:vc_officetel},
    ${fld:vc_zip},
    ${fld:vc_mobile},
    ${fld:vc_contact},
    ${fld:vc_company},
    ${fld:vc_jobtype},
    ${fld:vc_illnessrec},
    ${fld:vc_hobby},
    ${fld:vc_pt},
    ${fld:vc_mc},
    ${fld:vc_hiddencustomercode},
    ${fld:f_moneyleft},
    ${fld:vc_emcontact1},
    ${fld:vc_emcontact2},
    '${def:user}',
    {ts'${def:timestamp}'},
    ${fld:vc_remark}
)
