AND (
	CASE ${fld:daochu_salename_query} WHEN '1' THEN (${fld:daochu_yewuleixing} = '销售' AND finance.item IN (10,13,12)  OR finance.item::varchar = ${fld:daochu_yewuleixing})
		WHEN '2' THEN ptdef.ptlevelname =${fld:daochu_yewuleixing}
		WHEN '3' THEN finance.item::varchar = ${fld:daochu_yewuleixing}
		ELSE TRUE END
)