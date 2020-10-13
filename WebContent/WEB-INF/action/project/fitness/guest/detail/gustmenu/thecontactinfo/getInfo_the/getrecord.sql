select
	name,
	(case sex when
    	'0' then '女'
    	 when '1' then '男'
    	 when '2' then '未知'
    end) as i_sex,
	mobile,
	mobile2,
	(select posname from cc_position where code=cc_thecontact.positioncode ) as position,--zhiwei
	birthday,
	email,
	trill,
	wechat,
	(select storename from cc_branch where code=cc_thecontact.branchcode ) as branchname,
	possibility,
	thecourse,
	remark,
	(select officename from cc_guest where code=cc_thecontact.guestcode ) as theguestofficename,
	guestcode as refguestcode 
from 
	cc_thecontact 
where 
	code = ${fld:thecode} 
