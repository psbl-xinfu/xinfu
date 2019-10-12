insert into cc_public(
	tuid
	,datatype
	,guestcode
	,customercode
	,entertime
	,oldfollow
	,newfollow
	,reason
	,status
	,grabtime
	,org_id
) values(
	nextval('seq_cc_public')
	,${fld:datatype}
	,${fld:guestcode}
	,${fld:customercode}
	,(case when 
	${fld:mc} is not null then {ts '${def:timestamp}'}
	else '1979-04-11 15:00:20.436'
	 end)
	,${fld:mc}
	,${fld:mc}
	,'${resason}'
	,0
	,(case when 
	${fld:mc} is not null then {ts '${def:timestamp}'}
	else '1979-04-11 15:00:20.436'
	 end)
	,${fld:org_id}
)