UPDATE et_resource 
SET 
	fileid = ${fld:fileid}, 
	videoname = ${fld:videoname}, 
	videourl = ${fld:videourl}, 
	videodesc = ${fld:videodesc}, 
	timelength = ${fld:timelength}, 
	coverurl = ${fld:coverurl}, 
	updatedby = '${def:user}', 
	updated = {ts '${def:timestamp}'} 
WHERE tuid = ${fld:tuid}
