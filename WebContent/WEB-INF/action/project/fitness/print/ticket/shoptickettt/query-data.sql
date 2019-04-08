with paytype as (
	SELECT rowno::integer-1 AS rowno, param_text FROM (
		SELECT ROW_NUMBER() OVER() AS rowno, param_text, status FROM (
			SELECT param_text, status FROM cc_config WHERE CATEGORY = 'OtherPayWay' 
			and org_id = (case when 
				not exists(select 1 from cc_config c where c.org_id = ${def:org} and c.category=cc_config.category) 
				then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end) 
			ORDER BY tuid
		) AS t1 
	) AS t2 WHERE status = 1
) 
SELECT
	COALESCE((SELECT org_name FROM hr_org WHERE org_id = ${def:org} LIMIT 1),'') AS vc_head,
	(SELECT config.param_value FROM cc_config config WHERE config.category = 'Wish' 
	  	and config.org_id = (case when 
		not exists(select 1 from cc_config c where c.org_id = ${def:org} and c.category=config.category) 
		then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end)) as vc_foot,
	ls.tuid as vc_code,------凭条编号
	(
		select string_agg((good.goods_name || '       ' ||cg.standard || '       ' 
			|| lsg.price::numeric(10,2) ||  '       ' ||lsg.amount||'        '
			|| lsg.factmoney::numeric(10,2)),'<br/>')  
		from cc_leave_stock_goods lsg
		left join cc_goods good on lsg.goodsid=good.tuid and lsg.org_id = good.org_id 
		where ls.tuid =lsg.leave_stock_id and lsg.org_id = ls.org_id
	) as receipts,
	(select sum(amount) from cc_leave_stock_goods lsg where ls.tuid =lsg.leave_stock_id and lsg.org_id = ${def:org}) as amount ,
	ls.getmoney::numeric(10,2) as f_getmoney,  ---金额
	(case when ls.paytype = 1 then (
		select string_agg(param_text,';')
		from paytype where 0.00 != (case when get_arr_value(ls.pay_detail,rowno) = '' then '0.00' else get_arr_value(ls.pay_detail,rowno) end)::numeric(10,2)
	) else '会员卡支付' end) as paydetail,
	(select name from hr_staff where userlogin = ls.updatedby) as payeeuser,  ---收款人
	ls.updated as payeedate,  ---收款时间
	'商品销售' as vc_beizhu,
	(select name from cc_customer where code= ls.customercode and org_id = ${def:org}) as custname
from cc_leave_stock ls
left join cc_card card on card.code= ls.paycardcode and card.org_id = ls.org_id and card.isgoon = 0
LEFT JOIN cc_cardtype ct on ct.code=card.cardtype and ct.org_id = card.org_id 
left join cc_leave_stock_goods lg on ls.tuid = lg.leave_stock_id and lg.org_id = ls.org_id --zzn 
left join cc_goods cg on cg.tuid= lg.goodsid and  card.org_id = ls.org_id  --zzn
where ls.tuid::varchar=${fld:pk_value} and ls.org_id = ${def:org}


