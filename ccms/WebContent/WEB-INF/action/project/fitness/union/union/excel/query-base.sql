select
	tuid,
    group_name,
    status,
   created,
    remark
from t_union
where 1=1 
${filter}


