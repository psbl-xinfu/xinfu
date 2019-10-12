INSERT INTO cc_share_log(
	code,
	market_campaign_code,--营销活动编号
	expercarddef_code,--体验卡定义编号
	share_link,
	
	createdby,
	created,
	org_id
) VALUES(
	${seq:nextval@seq_cc_share_log},
	${fld:code},
	${fld:ecode},
	${fld:share_link},
	
	${fld:customercode},
	{ts '${def:timestamp}'},
	(
		select org_id from cc_market_campaign where code = ${fld:code} limit 1
	)
)