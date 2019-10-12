select 
	teachercode
from
	cc_classdef_limit
where classcode = ${fld:id} and org_id = ${def:org}
