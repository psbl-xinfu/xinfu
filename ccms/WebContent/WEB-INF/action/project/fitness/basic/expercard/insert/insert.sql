insert into cc_expercard
(
 code,
 name,
contact_phone,
address,
expertype,
experlimit,
validatetype,
enddate,
startdate,

useremark,
status,
createdby,
created,
org_id,

org_name,
market_campaign_code
)
values 
(
	${seq:nextval@seq_cc_expercard},
	 ${fld:c_cardname},
    ${fld:c_contact_phone},
  	${fld:c_address},
    ${fld:c_expertype},
    ${fld:c_experlimit},
    ${fld:c_validatetype},
    (case when ${fld:c_validatetype}=1 and ${fld:c_enddate} is null then (select enddate from cc_market_campaign where code = ${fld:m_code} and org_id = ${def:org} ) else ${fld:c_enddate} end),
    (case when ${fld:c_validatetype}=1 and ${fld:c_startdate} is null then (select startdate from cc_market_campaign where code = ${fld:m_code} and org_id = ${def:org} ) else ${fld:c_startdate} end),
    ${fld:c_useremark},
   2,
    '${def:user}',
    {ts'${def:timestamp}'},
    ${def:org},
    
      ${fld:c_name},
      ${fld:m_code}
)
