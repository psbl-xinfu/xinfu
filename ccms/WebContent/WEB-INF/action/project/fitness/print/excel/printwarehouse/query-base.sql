select
	t.vc_code,--库单编号
	r.vc_productid, 
	r.vc_fastcode, --快速码
	r.f_amount,--数量
	r.i_id,
	r.f_money,--金额
	d.vc_name,--商品名称
	d.vc_standard,--规格
	d.vc_unit,--单位
	r.f_price,
	r.vc_remark--备注
	,t.i_status 
from e_inout t 
inner join e_inoutrow r on r.vc_code = t.vc_code
left join e_productdef d on d.vc_pcode = r.vc_productid
where t.vc_code = ${fld:vc_code} 

AND (
	t.vc_clubcode = '${def:tenantry}' OR 
	charindex((SELECT tree_path FROM t_tenantry WHERE tenantry_id = ${def:tenantry}), (SELECT tree_path FROM t_tenantry WHERE t.vc_clubcode = tenantry_id::varchar)) >= 1 
)
