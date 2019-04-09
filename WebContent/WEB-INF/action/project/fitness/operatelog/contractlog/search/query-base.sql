select
clog.createdby,(case when clog.opertype = '102' then (select concat('认证ID:',appid) from cc_device where deviceid=clog.createdby) else hs.name end) as name,clog.pk_value,(case when clog.opertype = '100'  then clog.customercode 
 when clog.opertype = '101'  then clog.customercode 
  when clog.opertype = '102'  then clog.customercode 
 when clog.opertype = '103'  then clog.customercode
else cust.name end) as cname,cust.mobile,
	(select param_text from cc_config as cog where category='OpeCategory' and cog.param_value = clog.opertype) as type,
	clog.createdate,
	clog.remark
from cc_operatelog as clog

LEFT JOIN cc_customer as cust on cust.code=clog.customercode and cust.org_id=clog.org_id  

left join cc_device as ce on  ce.deviceid=clog.customercode and ce.org_id=clog.org_id

LEFT JOIN hr_staff as hs on hs.userlogin=clog.createdby and hs.org_id=clog.org_id 

LEFT JOIN hr_org as org on org.org_id=clog.org_id 

where clog.org_id = ${def:org}  
${filter}

order by clog.createdate desc
 