INSERT INTO cc_expercard_log(
	code,
	
	market_campaign_code,--营销活动编号
	expercarddef_code,--体验卡定义编号
	expercardcode,--体验卡号
	name,
	sex,
	mobile,
	
	status,
	created,
	org_id,
	
	sharecode
	) VALUES(
	${seq:nextval@seq_cc_expercard_log},
	${fld:code},
	${fld:ecode},
	${fld:expercardcode},
	${fld:cc_name},
	${fld:cc_sex},
	${fld:cc_mobile},
	
	1,
	{ts '${def:timestamp}'},
	${fld:org_id},
	
	
	(case when ${fld:customercode} is null
	then
	(SELECT code FROM cc_share_log where org_id = ${fld:org_id} and (
		share_link like  CONCAT('%?codes=',${fld:codes})
		or
		share_link like CONCAT('%?codes=',${fld:codes2}) 
		) order by created limit 1
	)
	else
	(SELECT code FROM cc_share_log where  createdby=${fld:customercode} and org_id = ${fld:org_id} order by created limit 1)
	end)
	)