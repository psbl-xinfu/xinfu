UPDATE et_resource 
SET
	coverurl = ${fld:coverurl}
	,updatedby = '${def:user}'
	,updated = {ts '${def:timestamp}'} 
WHERE fileid = ${fld:fileid}
