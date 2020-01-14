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
	  org_id,
	  contents
) 
VALUES(
	${seq:nextval@seq_cc_merger_transfer_log}
	,${fld:custcode}
	,${fld:newcustcode}
	,${fld:thecodelog}
	,${fld:yuanmc}
	,(select mc from cc_guest where code=${fld:newcustcode})
	,2
	,'${def:user}'
	,{ts '${def:timestamp}'}
	,${def:org}
	,${fld:contents}
)