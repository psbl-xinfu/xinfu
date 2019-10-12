INSERT INTO cc_cardcode(
	tuid
	,incode
	,cardcode
	,status
	,remark
	,org_id
) VALUES(
	${seq:nextval@seq_cc_cardcode}
	,${fld:incode}
	,${fld:cardcode}
	,1
	,${fld:remark}
	,${def:org}
)
