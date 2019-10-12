insert into cc_classdef_limit
(
    code,
    classcode,
    teachercode,
    createdby,
    created,
    org_id
)
values 
(
	${seq:nextval@seq_cc_classdef_limit},
	${seq:currval@seq_cc_classdef},
    ${fld:teachercode},
	'${def:user}',
	'${def:timestamp}',
    ${def:org}
)
