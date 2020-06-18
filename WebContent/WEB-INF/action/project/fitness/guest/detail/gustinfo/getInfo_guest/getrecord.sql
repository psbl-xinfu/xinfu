select
  	 code as guestcode,
	officename,--公司名称
	email,
	initmc,
	
	othertel,
	remark,
	  --公司类型
	(case customtype when '1' then '健身俱乐部'
	when '2' then '健身工作室'
	when '3' then '瑜伽会所'
	when '4' then '器械器'
	when '5' then '培训机构'
	else  '其他'
end	) as customtype

	,(case communication when '1' then '客户'
	when '2' then '重点意向客户'
	when '3' then '咨询客户'
	when '4' then '陌生客户'
	 end) as communication,  --客户分类
	 custclass --客户详细分类
	,guestnum --公司数量
	,thepublic --公众号
	
	,(case channel when '1' then '抖音' 
	when '2' then '公众号'
	when '3' then '转介绍'
	when '4' then '展会'
	when '5' then '论坛'
	when '6' then '粉丝客户'
	else '其他'
end) as channel --获客渠道
	,createdby  --操作人
	,created  --操作时间
	,(
		select t.domain_text_cn from t_domain t 
		where t.namespace = 'Province' 
		and t.domain_value = cc_guest.province2::varchar 
	) as province,
	(
		select t.domain_text_cn from t_domain t 
		where t.namespace = 'City' 
		and t.domain_value = cc_guest.city2::varchar
	) as city,

	
	(select name from hr_staff where userlogin=cc_guest.mc 
	) as mc
from 
	cc_guest 
where 
	code = ${fld:id} and org_id=${fld:menuorgid}
