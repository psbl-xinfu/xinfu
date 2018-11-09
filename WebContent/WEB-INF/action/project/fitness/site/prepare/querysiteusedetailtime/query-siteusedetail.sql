select
	to_char(prepare_endtime, 'HH24')::integer as endtime,
	(case when ${fld:prepare_date}::date<='${def:date}'::date then 
	to_char((case when '${def:timestamp}'::time>prepare_starttime then prepare_endtime-'${def:timestamp}'::time else 
		prepare_endtime-prepare_starttime end), 'HH24')::integer else 1 end) as hour
from cc_siteusedetail
where code = ${fld:code}