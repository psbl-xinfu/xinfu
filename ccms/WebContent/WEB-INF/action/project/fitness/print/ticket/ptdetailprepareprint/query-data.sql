SELECT
  	(SELECT org_name FROM hr_org WHERE org_id = ${def:org}) as vc_head
	--,p.vc_code --预约上课主键
    ,g.code as vc_code --凭条编号
	,p.customercode as vc_customercode --会员编号
	,p.cardcode as vc_cardcode --会员编号
	,c.name as vc_name --会员名称
	,d.ptlevelname as vc_ptlevelname --pt课级别
	,g.leftcount::int as f_leftcount --剩余次数
	,g.ptfee as f_ptfee --课时费
	,f.name AS pt_name --教练名称
	,(select name from hr_staff where hr_staff.userlogin= '${def:user}' and org_id = ${def:org})  as vc_iuser --操作员
  	,to_char(p.preparedate,'yyyy-MM-dd') || ' ' || p.starttime AS prepare_time
	,to_char('${def:timestamp}'::timestamp,'yyyy-MM-dd hh24:mi:ss') AS oper_time
  	,(SELECT config.param_value FROM cc_config config WHERE config.category = 'Wish' 
	  	and config.org_id = (case when 
		not exists(select 1 from cc_config c where c.org_id = ${def:org} and c.category=config.category) 
		then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end)) as wish
	,(select (ptmoney/pttotalcount)::numeric(10,2) from cc_ptrest where code = p.ptrestcode and org_id = p.org_id) as sjprice
FROM cc_ptprepare p 
LEFT JOIN cc_ptlog g ON p.code = g.preparecode and p.org_id = g.org_id
LEFT JOIN cc_ptdef d ON g.ptlevelcode = d.code and g.org_id = d.org_id
LEFT JOIN hr_staff f ON p.ptid = f.userlogin  and p.org_id = f.org_id
LEFT JOIN cc_customer c ON p.customercode = c.code and p.org_id = c.org_id
where 
	p.code = ${fld:pk_value} and p.org_id =${def:org}