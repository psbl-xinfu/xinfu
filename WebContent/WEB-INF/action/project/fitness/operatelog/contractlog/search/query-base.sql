select
clog.createdby,hs.name,clog.pk_value,cust.name as cname,cust.mobile,
	(select param_text from cc_config as cog where category='OpeCategory' and cog.param_value = clog.opertype) as type,
	clog.createdate
from cc_operatelog as clog

LEFT JOIN cc_customer as cust on cust.code=clog.customercode 

LEFT JOIN hr_staff as hs on hs.userlogin=clog.createdby

LEFT JOIN hr_org as org on org.org_id=clog.org_id
where clog.org_id = ${def:org}  
${filter}

order by clog.code desc
 