select 

	(SELECT org_name FROM hr_org WHERE org_id = ${def:org}) as vc_head
	,(SELECT vc_content as wish FROM e_cnfg WHERE vc_category = 'Wish') as wish,
	e.code as billcode, --凭证号
	e.cardcode as cardcode,--会员卡号
	get_arr_value(g.relatedetail,0) as vc_customer, --会员编号
	r.name as vc_name, --会员姓名
	get_arr_value(g.relatedetail,1) as zuguino,--柜号
	g.remark as billtype, --业务类型：退柜
	h.name as opname ,--操作员
	get_arr_value(g.relatedetail,0) as f_factmoney,--收款
	g.created as c_idate  --操作日期
from cc_operatelog g 
inner join cc_finance e on e.operationcode=g.code and e.org_id = g.org_id
inner join hr_staff h on g.createdby=userlogin 
inner join cc_customer r on r.code = get_arr_value(g.relatedetail,0) and r.org_id = g.org_id
where g.code=${fld:pk_value} and g.org_id = ${def:org}
