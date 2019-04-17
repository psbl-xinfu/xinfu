insert into cc_public(
	tuid
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
	,1
	,'XG'||to_char({ts'${def:date}'},'yy')||lpad(${seq:currval@seq_cc_guest}::varchar, 6, '0')
	,{ts '${def:timestamp}'}
	,${fld:cc_mc}
	,${fld:cc_mc}
	,'新建资源进入public'
	,0
	,{ts '${def:timestamp}'}
	,${def:org}
)