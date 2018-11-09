select
	concat('<input type="checkbox" name="unionlist" value="', tuid, '" />') AS checklink,
	tuid,
    group_name,
    status,
    createdby,
    created,
    remark 
from t_union
where 1=1 and status !=0
${filter}
${orderby}

