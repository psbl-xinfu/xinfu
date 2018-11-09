insert into cc_goods_stock
(
	tuid,
	storageid,
	goodsid,
	quantity,
	totalprice,
	status,
	created,
	createdby,
	org_id
)

(
	select 
		${seq:nextval@seq_cc_goods_stock},
		es.storageid,
		esg.goodsid,
		esg.amount,
		esg.factmoney,
		1,
	    {ts'${def:timestamp}'},
	    '${def:user}',
	    ${def:org}
	from cc_enter_stock es
	inner join cc_enter_stock_goods esg on es.tuid = esg.enter_stock_id and es.org_id = esg.org_id
	where es.org_id = ${def:org} and es.tuid = ${fld:stocktuid}
	and not exists(
		select 1 from cc_goods_stock t where t.goodsid = esg.goodsid and es.storageid = t.storageid and t.status != 0 
		and t.org_id = es.org_id
	)
)
