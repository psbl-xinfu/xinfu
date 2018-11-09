select
	'<input type="radio" name="contractcode" value="'||code||'" />' AS radiolink,
	relatedetail,
	inimoney,
	normalmoney,
	factmoney,
	(select name from hr_staff where userlogin=cc_operatelog.createdby) as createdby,
	createtime,
	createdate,
	(select domain_text_cn from t_domain where t_domain.domain_value=opertype and NAMESPACE ='OperateType') as opertype
from cc_operatelog
where 1=1
${filter} 
AND (
	org_id = ${def:org} OR 
	charindex((SELECT org_path FROM hr_org WHERE org_id = ${def:org}), 
	(SELECT org_path FROM hr_org WHERE cc_operatelog.org_id = hr_org.org_id)) >= 1 
)
order by createdate desc, createtime desc