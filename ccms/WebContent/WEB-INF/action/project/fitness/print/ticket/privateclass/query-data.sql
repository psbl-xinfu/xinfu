SELECT
	(SELECT tenantry_name FROM t_tenantry WHERE tenantry_id = ${def:tenantry}) as vc_head
	,g.vc_code --凭条编号
	,g.vc_customercode --会员编号
	,g.vc_cardcode
	,c.vc_name --会员名称
	,d.vc_ptlevelname --pt课级别
	,g.f_leftcount --剩余次数
	,g.f_ptfee --课时费
	,f.name AS pt_name --教练名称
	,f2.name AS vc_iuser --操作员
	,to_char(g.c_itime,'yyyy-MM-dd hh24:mi:ss') AS oper_time
	,(SELECT config.param_value FROM cc_config config WHERE config.category = 'Wish' 
	  	and config.org_id = (case when 
		not exists(select 1 from cc_config c where c.org_id = ${def:org} and c.category=config.category) 
		then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end)) as wish
FROM e_ptlog g 
LEFT JOIN e_ptdef d ON g.vc_ptlevelcode = d.vc_code 
LEFT JOIN e_customer c ON g.vc_customercode = c.vc_code 
LEFT JOIN hr_staff f ON g.vc_ptid = f.userlogin 
LEFT JOIN hr_staff f2 ON g.vc_iuser = f2.userlogin 
WHERE g.vc_code = ${fld:pk_value}
