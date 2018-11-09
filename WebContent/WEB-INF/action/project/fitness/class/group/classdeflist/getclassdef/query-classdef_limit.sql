select 
	teachercode
from cc_classdef_limit
where classcode = ${fld:code} and org_id = ${def:org}