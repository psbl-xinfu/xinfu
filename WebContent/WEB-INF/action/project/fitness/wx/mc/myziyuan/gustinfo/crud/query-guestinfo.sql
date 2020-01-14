select 
	gt.code,
	gt.officename,--公司名称
	(select domain_text_cn from t_domain 
	WHERE namespace = 'Province' AND is_enabled = '1' and domain_value::int=gt.province2) as province,--省
	(select domain_text_cn from t_domain 
	WHERE namespace = 'City' AND is_enabled = '1' and domain_value::int=gt.city2) as city,--市
	gt.officeaddr,--地址
	gt.customtype,--公司类型
	gt.communication,--客户分类
	gt.custclass, --客户详细分类
	the.code as thecode,
	the.name,
	the.mobile,
	gt.guestnum
from cc_guest gt
left join cc_thecontact the on gt.code=the.guestcode
where gt.code=${fld:guestcode} and the.status=1
