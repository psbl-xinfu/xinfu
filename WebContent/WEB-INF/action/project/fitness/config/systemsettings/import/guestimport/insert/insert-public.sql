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
	,${fld:officename}
	,1
	,${fld:guestcode}
	,{ts '${def:timestamp}'}
	,${fld:mc}
	,${fld:mc}
	,'导入资源的时候进入public'
	,0
	,{ts '${def:timestamp}'}
	,${def:org}
)