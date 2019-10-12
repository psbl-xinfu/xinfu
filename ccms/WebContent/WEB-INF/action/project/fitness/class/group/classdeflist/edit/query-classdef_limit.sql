select 
	teachercode
from cc_classdef_limit
where classcode = (select classcode from cc_classlist where code=${fld:code}
and org_id = ${def:org}) and org_id = ${def:org}