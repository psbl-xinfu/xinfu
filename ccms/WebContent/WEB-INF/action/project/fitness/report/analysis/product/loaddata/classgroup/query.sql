select
	cd.code,
	cd.class_name as name,
	count(1) as num
from cc_classprepare cp
inner join cc_classlist cl on cp.classlistcode = cl.code and cp.org_id = cl.org_id
inner join cc_classdef cd on cd.code = cl.classcode and cd.org_id = cl.org_id
where cp.org_id = ${def:org} and cp.status = 2
and cp.created::date >= ${fld:fdate} AND cp.created::date <= ${fld:tdate} 
GROUP BY cd.code,cd.class_name
