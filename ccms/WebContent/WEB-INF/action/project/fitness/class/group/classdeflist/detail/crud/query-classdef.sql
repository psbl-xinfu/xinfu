select
	code,
	class_name,
	class_ename,
	times
from cc_classdef
where status = 1
 and org_id = ${def:org}