update cc_comm set commresult=${fld:the_state},
	nexttime=${fld:_start_date},
	remark=${fld:scremark},
	created={ts'${def:timestamp}'},
	createdby='${def:user}'
 where code=${fld:commcode} 