insert into cc_expercard
(
 code,
 name,
covertype,
covervalue,
descr,
contact_phone,

address,
expertype,
experlimit,
validatetype,
enddate,
startdate,

isneddmobile,
useremark,
status,
createdby,
created,
org_id
)
values 
(
	${seq:nextval@seq_cc_expercard},
	 ${fld:c_cardname},
    ${fld:c_covertype},
    ${fld:c_covervalue},
 	${fld:c_descr},
    ${fld:c_contact_phone},
    
  	${fld:c_address},
    ${fld:c_expertype},
    ${fld:c_experlimit},
    ${fld:c_validatetype},
    ${fld:c_enddate},
    ${fld:c_startdate},
    
    ${fld:c_isneddmobile},
    ${fld:c_useremark},
   2,
    '${def:user}',
    {ts'${def:timestamp}'},
    ${def:org}

)
