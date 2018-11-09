select 
	tuid,
	fileid,
	videoname,
	timelength,
	created,
	createdby
from et_resource 
where status = 1 
	
	${filter}
	${orderby}