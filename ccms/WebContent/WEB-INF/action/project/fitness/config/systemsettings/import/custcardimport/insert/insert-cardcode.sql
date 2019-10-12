INSERT INTO cc_cardcode(
	tuid
	,incode
	,cardcode
	,status
	,org_id
) 
values(
	${seq:nextval@seq_cc_cardcode},
	${fld:incode},
	${fld:cardcode},
	1,
	${def:org}
)
--SELECT 
--	${seq:nextval@seq_cc_cardcode},
--	${fld:incode},
--	${fld:cardcode},
--	1,
--	${def:org},
--FROM dual 
--WHERE ${fld:cardcode} IS NOT NULL AND ${fld:cardcode} != '' 
--AND ${fld:incode} IS NOT NULL AND ${fld:incode} != '' 
