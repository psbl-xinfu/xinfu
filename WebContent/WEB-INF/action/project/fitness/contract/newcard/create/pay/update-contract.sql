UPDATE cc_contract 
SET 
	status = 2
	,collectby = '${def:user}'
	,collectdate = '${def:date}'
	,collecttime = '${def:time}'
	,billcode = currval('seq_cc_finance')::varchar
	,relatedetail = concat(
		get_arr_value(relatedetail, 0),';', COALESCE(${fld:cardcode},'') ,';'
		,COALESCE(get_arr_value(relatedetail, 2),''),';',COALESCE(get_arr_value(relatedetail, 3),''),';'
		,COALESCE(get_arr_value(relatedetail, 4),''),';',COALESCE(get_arr_value(relatedetail, 5),''),';'
		,COALESCE(get_arr_value(relatedetail, 6),''),';',COALESCE(get_arr_value(relatedetail, 7),''),';'
		,COALESCE(get_arr_value(relatedetail, 8),''),';',COALESCE(get_arr_value(relatedetail, 9),''),';'
		,COALESCE(get_arr_value(relatedetail, 10),''),';',COALESCE(get_arr_value(relatedetail, 11),''),';'
		,COALESCE(get_arr_value(relatedetail, 12),''),';',COALESCE(get_arr_value(relatedetail, 13),''),';'
		,COALESCE(get_arr_value(relatedetail, 14),''),';',COALESCE(get_arr_value(relatedetail, 15),''),';'
		,COALESCE(get_arr_value(relatedetail, 16),''),';',COALESCE(get_arr_value(relatedetail, 17),''),';'
		,COALESCE(get_arr_value(relatedetail, 18),''),';',COALESCE(get_arr_value(relatedetail, 19),''),';'
		,COALESCE(get_arr_value(relatedetail, 20),''),';',COALESCE(get_arr_value(relatedetail, 21),''),';'
		,COALESCE(get_arr_value(relatedetail, 22),''),';',COALESCE(get_arr_value(relatedetail, 23),''),';'
		,COALESCE(get_arr_value(relatedetail, 24),''),';',COALESCE(get_arr_value(relatedetail, 25),''),';'
		,COALESCE(get_arr_value(relatedetail, 26),''),';',COALESCE(get_arr_value(relatedetail, 27),''),';'
	)
	,factmoney = ${fld:factmoney} 
	,stagemoney = ${fld:factmoney} 
	,pay_detail = ${fld:paydetail} 
WHERE code = ${fld:contractcode} AND org_id = ${def:org}
