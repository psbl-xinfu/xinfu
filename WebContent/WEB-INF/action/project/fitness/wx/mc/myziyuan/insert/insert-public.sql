insert into cc_public(
	tuid
	,officename
	,datatype
	,guestcode
	,entertime
	,oldfollow
	,newfollow
	,reason
	,status
	,grabtime
	,org_id
) values(
	nextval('seq_cc_public')
	,${fld:company}
	,1
	,${seq:currval@seq_cc_guest}
	,{ts '${def:timestamp}'}
	,'${def:user}'
	,'${def:user}'
	,'新建资源进入public'
	,0
	,{ts '${def:timestamp}'}
	,${def:org}
)