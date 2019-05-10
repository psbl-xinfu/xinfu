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
select
	(SELECT org_name FROM hr_org WHERE org_id = ${def:org}) as vc_head,
	sl.code as bills_code,
	sl.name as vc_name,--货号名称
	sl.price::numeric(10,2) as f_price,--单价
	sl.amount::int as f_amount,--数量
	sl.getmoney::numeric(10,2) as f_money,--金额
	(select name from cc_customer cust where cust.code = sl.customercode and cust.org_id = sl.org_id) as cust_name, --姓名
	(select name from hr_staff where userlogin = sl.seller) as vc_ouser, --销售员
	sl.getmoney::numeric(10,2) as f_getmoney,
	(select name from hr_staff where userlogin= sl.createdby) as vc_auser,----操作人
	to_char(sl.collectdate ::timestamp,'yyyy-MM-dd hh24:mi:ss') AS c_adate,----收款时间
	sl.itemcode as vc_itemcode,--货号编号
	sl.remark as vc_beizhu,
	(select string_agg(param_text,';')
		from paytype where 0.00 != (case when get_arr_value(sl.pay_detail,rowno) = '' then '0.00' else get_arr_value(sl.pay_detail,rowno) end)::numeric(10,2)
	) as paydetail,
	(SELECT config.param_value FROM cc_config config WHERE config.category = 'Wish' 
	 and config.org_id = (case when 
	 not exists(select 1 from cc_config c where c.org_id = ${def:org} and c.category=config.category) 
	 then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end)) as wish,
	 sl.discount
from cc_singleitem sl
where sl.code=${fld:pk_value} and sl.org_id = ${def:org} 
group BY sl.code



