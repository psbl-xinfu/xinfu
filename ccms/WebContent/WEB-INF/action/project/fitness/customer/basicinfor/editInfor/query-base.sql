select
    code,
    (case status when 0 then '无效' when 1 then '正常' when 2 then '已过期' else '' end) as i_status,
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
from 
	cc_customer
where 
	code = ${fld:vc_code} and org_id = ${def:org}

