update cc_classdef set 
	class_name=${fld:class_name},
	class_ename=${fld:class_ename},
	times=${fld:times},
	class_bgcolor=${fld:class_bgcolor},
	islimitroom=${fld:islimitroom},
	classroomcode=${fld:classroomcode},
	isprepare=${fld:isprepare},
	allowbook=${fld:allowbook}*60,
	allowbeginbook=(case when ${fld:isallowbeginbook}='0' then null else ${fld:allowbeginbook}*60 end),
	classinfo=${fld:classinfo},
	mincount=${fld:mincount},
	status=${fld:status}
where
	code = ${fld:vc_code} and org_id = ${def:org}
