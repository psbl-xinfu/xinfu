select
	concat('<label class="am-checkbox"><input type="checkbox"  data-am-ucheck name="datalist" ',
	'value="',cd.code::varchar,'" ></label>') as application_id
	,substring((cl.classtime ::varchar) from 0 for 6) as classtime
	,cd.class_name
	,s.name
	,COALESCE(cl.nowcount, 0) as nowcount
	,COALESCE(cl.personcount, 0) as personcount
from
    cc_classdef cd
    left join cc_classlist cl ON cl.classcode=cd.code
    left join hr_staff s ON s.userlogin=cl.teacherid
where cd.status = 1  and cd.org_id = '${def:org}'
    
${filter}

order by cd.created desc

