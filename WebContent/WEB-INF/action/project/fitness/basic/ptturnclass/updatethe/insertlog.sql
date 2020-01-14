INSERT INTO cc_merger_transfer_log(
	  code,
	  yguestcode,
	  xguestcode,
	  thecode,
	  ymc,
	  xmc,
	  type,
	  createdby,
	  created,
	  org_id
) 
VALUES(
	${seq:nextval@seq_cc_merger_transfer_log}
	,${fld:ccguestcode}
	,${fld:newthecode}
	,${fld:thecode}
	,(select mc from cc_guest where code=${fld:ccguestcode})
	,(select mc from cc_guest where code=${fld:newthecode})
	,1
	,'${def:user}'
	,{ts '${def:timestamp}'}
	,${def:org}
)