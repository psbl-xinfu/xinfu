insert into cc_classdef
(
	code,
	class_name,
	class_ename,
	times,
	class_bgcolor,
	islimitroom,
	classroomcode,
	isprepare,
	allowbook,
	allowbeginbook,
	classinfo,
	classfee,
	status,
	mincount,
	createdby,
	created,
	org_id
)
values
(
	${seq:nextval@seq_cc_classdef},
	${fld:class_name},
	${fld:class_ename},
	${fld:times},
	${fld:class_bgcolor},
	${fld:islimitroom},
	${fld:classroomcode},
	${fld:isprepare},
	${fld:allowbook}*60,
	(case when ${fld:isallowbeginbook}='0' then null else ${fld:allowbeginbook}*60 end),
	${fld:classinfo},
	0,
	${fld:status},
	${fld:mincount},
	'${def:user}',
	'${def:timestamp}',
	${def:org}
)
