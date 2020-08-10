select 
	(select officename from cc_guest where code=cc_thecontact_log.guestcode) as officename ,
	(select posname from cc_position where code= cc_thecontact_log.positioncode) as posname,
	possibility,
	thecourse,
	(select storename from cc_branch where code=cc_thecontact_log.branchcode) as storename,
	created,
	createdby
from cc_thecontact_log 
where thecode=${fld:thecode}
 order by created desc