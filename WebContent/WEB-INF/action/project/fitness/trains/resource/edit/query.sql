select 
	tuid, 
	status, 
	fileid, 
	videoname, 
	videourl, 
	videodesc, 
	timelength, 
	coverurl, 
	remark, 
	createdby, 
	created 
from et_resource 
where tuid = ${fld:id}
