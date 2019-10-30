select
	cc_guest.officename,
	(select name from hr_staff where userlogin=cc_mcchange.oldmc) as vc_oldmc,
	(select name from hr_staff where userlogin=cc_mcchange.newmc) as vc_newmc,
	cc_mcchange.remark as vc_remark,
	(select name from hr_staff where userlogin=cc_mcchange.createdby) as vc_iuser,
	cc_mcchange.created as vc_itime
from  cc_mcchange
left join cc_guest on cc_mcchange.guestcode=cc_guest.code  and cc_guest.org_id = '${def:org}' 
AND cc_mcchange.org_id = '${def:org}' 
where cc_mcchange.guestcode=${fld:id}


