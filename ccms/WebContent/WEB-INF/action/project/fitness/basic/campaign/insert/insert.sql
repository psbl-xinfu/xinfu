insert into cc_campaign
(
    code,
    campaign_name,
    startdate,
    enddate,
    discount,
    org_id,
    cardtype,
    remark
)
values 
(
	${seq:nextval@seq_cc_campaign},
    ${fld:camp_name},
    ${fld:startdate},
    ${fld:enddate},
    ${fld:discount},
    ${def:org},
    ${fld:vc_cardtype},
    ${fld:vc_remark}
)
							

