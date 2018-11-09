select
	(cl.limitcount-(select count(1) from cc_classprepare where classlistcode = cl.code and org_id = ${def:org})) as residue,
	(select count(1) from cc_classprepare where classlistcode = cl.code and org_id = ${def:org}) as nowcount
from cc_classlist cl
left join cc_classdef cd on cd.code = cl.classcode and cd.org_id = cl.org_id
left join cc_classroom cr on cl.classroomcode = cr.code and cl.org_id = cr.org_id
where cl.code=${fld:code}
 and cl.org_id = ${def:org}