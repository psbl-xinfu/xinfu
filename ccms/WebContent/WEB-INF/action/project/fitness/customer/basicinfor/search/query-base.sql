select
	code,
	(case status when 1 then '有效' 
	when 0 then '无效' end) i_status,
    --e_customerphoto.vc_url,
    name,
    (case sex when 0 then '未知'
     when 1 then '男'
     when 2 then '女' end) i_sex,
   (select org_name from hr_org where hr_org.org_id=c.org_id ) as vc_club,
    birthdate,
	(case rank when '01' then '普通会员' end)vc_rank,
	email,
    idnumber,
    nation,
    officetel,
    addr,
    hometel,
	zip,
	mobile,
    contact,
    company,
    jobtype,
    illnessrec,
    hobby,
	pt,
	(select name from hr_staff where userlogin=mc and org_id = ${def:org}) as vc_mc,
    guestcode as hiddencustomercode,
    moneyleft,
    emcontact1,
    emcontact2,
    createdby,
	created,
	remark
from cc_customer c
where 1=1 and c.org_id = ${def:org}
${filter}


