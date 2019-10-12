select
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
	status,
	mincount
from
	cc_classdef
where
	code=${fld:id} and org_id = ${def:org}
