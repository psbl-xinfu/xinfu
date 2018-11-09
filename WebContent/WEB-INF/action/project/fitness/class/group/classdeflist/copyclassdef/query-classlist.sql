select
	code,
	classtime,
	(select name from hr_staff where userlogin = teacherid) as name,
	(select class_name from cc_classdef where code = classcode and cc_classdef.org_id = ${def:org}) as class_name
from cc_classlist
where code=${fld:code}
 and org_id = ${def:org}