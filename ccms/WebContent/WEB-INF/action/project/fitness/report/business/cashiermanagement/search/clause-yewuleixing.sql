AND (
	CASE ${fld:salename_query} 
		WHEN '2' THEN ptdef.ptlevelname =${fld:yewuleixing}
		else finance.item = ${fld:yewuleixing} END
	)