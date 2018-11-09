INSERT INTO et_resource(
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
) VALUES (
	${seq:nextval@seq_et_resource},
	1,
	${fld:fileid},
	${fld:videoname}, 
	${fld:videourl}, 
	${fld:videodesc}, 
	${fld:timelength}, 
	${fld:coverurl}, 
	NULL, 
	'${def:user}', 
	{ts '${def:timestamp}'}
);