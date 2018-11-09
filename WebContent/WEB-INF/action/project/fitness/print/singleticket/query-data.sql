with paytype as (
	SELECT rowno::integer-1 AS rowno, vc_content FROM (
		SELECT ROW_NUMBER() OVER() AS rowno, vc_content, i_useravailable FROM (
			SELECT vc_content, i_useravailable FROM E_CNFG WHERE VC_CATEGORY = 'OtherPayWay' ORDER BY cnfg_id
		) AS t1 
	) AS t2 WHERE i_useravailable = '1'
) 
select
   (SELECT org_name FROM hr_org WHERE org_id = ${def:org}) as vc_head,
   (SELECT  vc_content  FROM e_cnfg WHERE  vc_category = 'Wish')  as  vc_foot,
   sl.code as bills_code,
   sl.name as vc_name,--货号名称
   sl.price as f_price,--单价
   sl.amount as f_amount,--数量
   sl.money::numeric(10,2) as f_money,--金额
    ((sld.name || '<br/>' || sl.itemcode || '      ' || sl.price::numeric(10,2) || '*'||sl.amount||'       '||sl.money::numeric(10,2)),'<br/>') as gouwu_xiaopiao,
    (select count(1) from cc_singleitemdef cs where cs.code =sl.itemcode and cs.org_id = ${def:org}) as gouwu_jianshu,
   (case sl.paytype when 1 then '现金/银行卡支付' when 2 then '储蓄卡支付' else '' end) as i_paytype,
   sl.cardcode as vc_cardcode, --卡号
   (select cust.name from cc_customer cust where cust.code = card.customercode and cust.org_id = ${def:org}) as vc_name, --姓名
   staff.name as vc_ouser, --销售员
   sl.getmoney as f_getmoney,
---e_singleitem.vc_cardcode,
   --hr_staff.name as vc_ouser,
----e_singleitem.vc_iuser,
   (select name from hr_staff where userlogin= f.createdby) as vc_auser,----操作人
  -- e_finance.vc_auser,----操作人
   f.created as c_adate,----收款时间
 
   sl.createdby as vc_iuser,
   sl.itemcode as vc_itemcode,--货号编号
   sl.remark  as   vc_beizhu
   ,(
		select string_agg(vc_content||'：'||get_arr_value(sl.pay_detail,rowno),'<br/>') 
		from paytype
	) as paydetail
from cc_singleitem sl
left join cc_singleitemdef sld on sld.code=sl.itemcode and sl.org_id = sld.org_id
left join hr_staff staff on staff.userlogin=sl.seller
inner join cc_finance f on f.operationcode=sl.code and f.item=30 and f.type=3 and f.org_id = sl.org_id
left join cc_card card on card.code = sl.cardcode and card.org_id = sl.org_id
where sl.code=${fld:pk_value} and card.isgoon = 0 and sl.org_id = ${def:org}
