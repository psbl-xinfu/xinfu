select
	class_ename,
	class_bgcolor,
	isprepare,
	times as timeslen,
	classfee,
	to_char(((select classtime from cc_classlist where code = ${fld:code} and org_id = ${def:org})::time+ (times||' minutes')::interval),'HH24:MI') as times,
	classroomcode as crcode
from cc_classdef
where code=(select classcode from cc_classlist where code = ${fld:code} and org_id = ${def:org})
 and org_id = ${def:org}