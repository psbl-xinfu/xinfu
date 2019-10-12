select 

	(SELECT tenantry_name FROM t_tenantry WHERE tenantry_id = ${def:tenantry}) as vc_head
	,(SELECT config.param_value FROM cc_config config WHERE config.category = 'Wish' 
	  	and config.org_id = (case when 
		not exists(select 1 from cc_config c where c.org_id = ${def:org} and c.category=config.category) 
		then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end)) as wish,
e.vc_code as billcode, --凭证号
e.vc_cardcode as cardcode,--会员卡号
get_arr_value(g.vc_relatecode,0) as vc_customer, --会员编号
r.vc_name, --会员姓名
get_arr_value(g.vc_relatecode,1) as zuguino,--柜号
g.vc_remark as billtype, --业务类型：退柜
h.name as opname ,--操作员
get_arr_value(g.vc_description,0) as f_factmoney,--收款
g.c_idate  --操作日期
from e_operatelog g 
inner join e_finance e on e.vc_operationcode=g.vc_code
inner join hr_staff h on g.vc_iuser=userlogin
inner join e_customer r on r.vc_code = get_arr_value(g.vc_relatecode,0)
where g.vc_code=${fld:pk_value} 
