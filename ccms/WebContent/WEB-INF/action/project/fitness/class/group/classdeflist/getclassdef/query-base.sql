select
	class_ename,
	class_bgcolor,
	isprepare,
	times as timeslen,
	classfee,
	to_char((${fld:classtime}::time+ (times||' minutes')::interval),'HH24:MI') as times,
	classroomcode
from cc_classdef
where code=${fld:code}
 and org_id = ${def:org}