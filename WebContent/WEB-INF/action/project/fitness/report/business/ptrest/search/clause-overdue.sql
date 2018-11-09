 and (
 	case ${fld:overdue} when 2 then t.ptenddate::date < '${def:date}'::date 
 	else t.ptenddate::date >= '${def:date}'::date or t.ptenddate is null 
 	end
)