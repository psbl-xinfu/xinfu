select 
    code,
	class_name
from cc_classdef
where status=1 and org_id = ${def:org}