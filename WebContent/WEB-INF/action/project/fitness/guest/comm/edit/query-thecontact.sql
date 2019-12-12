select 
	cm.guestcode,
	cm.code as commcode,
	(select name from cc_thecontact where code=cm.thecontactcode) as thename,--联系人名称
	(select officename from cc_guest where code=cm.guestcode) as officename,
	cm.commresult,
	cm.remark,
	cm.created,
	cm.nexttime
from cc_comm cm
where cm.code =${fld:commcode}  and cm.org_id=${def:org}
