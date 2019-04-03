with paytype as (
	SELECT rowno::integer-1 AS rowno, param_text FROM (
		SELECT ROW_NUMBER() OVER() AS rowno, param_text, status FROM (
			SELECT param_text, status FROM cc_config WHERE CATEGORY = 'OtherPayWay' and org_id = ${def:org} ORDER BY tuid
		) AS t1 
	) AS t2 WHERE status = 1
) 
select
	(SELECT org_name FROM hr_org WHERE org_id = ${def:org}) as vc_head,
	sl.code as bills_code,
	sl.name as vc_name,--货号名称
	sl.price::numeric(10,2) as f_price,--单价
	sl.amount::int as f_amount,--数量
	sl.money::numeric(10,2) as f_money,--金额
	(case sl.paytype when 1 then '现金/银行卡支付' when 2 then '储蓄卡支付' else '' end) as i_paytype,
	(select name from cc_customer cust where cust.code = sl.customercode and cust.org_id = sl.org_id) as cust_name, --姓名
	(select name from hr_staff where userlogin = sl.seller) as vc_ouser, --销售员
	sl.getmoney::numeric(10,2) as f_getmoney,
	(select name from hr_staff where userlogin= sl.createdby) as vc_auser,----操作人
	to_char(sl.collectdate ::timestamp,'yyyy-MM-dd hh24:mi:ss') AS c_adate,----收款时间
	sl.itemcode as vc_itemcode,--货号编号
	sl.remark as vc_beizhu,
	(case when sl.paytype=2 then concat('储蓄卡支付：', sl.normalmoney) else
	(select string_agg(param_text||'：'||get_arr_value(sl.pay_detail,rowno),'<br/>') from paytype)
	 end) as paydetail,
	(SELECT config.param_value FROM cc_config config WHERE config.category = 'Wish' 
	 and config.org_id = (case when 
	 not exists(select 1 from cc_config c where c.org_id = ${def:org} and c.category=config.category) 
	 then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end)) as wish
from cc_singleitem sl
where sl.code=${fld:pk_value} and sl.org_id = ${def:org} 
group BY sl.code



