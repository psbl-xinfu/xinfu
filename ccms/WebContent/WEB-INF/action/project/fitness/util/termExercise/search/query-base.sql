select  cust.name,(case WHEN cust.sex = '0' then '女' when cust.sex = '1' then '男' else '未知' end) as sex,cust.mobile,
(case when (select enddate from cc_card where customercode=cust.code and isgoon!='-1' and status!=0 and org_id=cust.org_id order by enddate desc limit 1)::date >='${def:date}'
then '有效'  else '无效' end) as status,
(case when (select code from cc_inleft where customercode = cust.code and org_id = cust.org_id limit 1) is null 
	then cust.indate else (select max(indate) from cc_inleft where customercode = cust.code and org_id = cust.org_id) end) as indate,--最后锻炼时间
(NOW()::date-
(case when (select code from cc_inleft where customercode = cust.code and org_id = cust.org_id limit 1) is null 
	then cust.indate else (select max(indate) from cc_inleft where customercode = cust.code and org_id = cust.org_id) end)::date) as tians,
(SELECT hr_staff.name from hr_staff where hr_staff.userlogin=cust.mc) as mc
from cc_customer cust  GROUP BY cust.code 

HAVING 

 not EXISTS(
	select 1 from cc_inleft inleft
	where inleft.customercode = cust.code and
	(case when ${fld:shijian} is null then
	(case when (select code from cc_inleft where customercode = cust.code and org_id = cust.org_id limit 1) is null 
	then cust.indate else (select max(indate) from cc_inleft where customercode = cust.code and org_id = cust.org_id) end)>(now() -'30 day'::INTERVAL) 
	else 1=1 ${filter}

	end)
) and cust.org_id=${def:org}  and
(case when ${fld:mc} is null then 1=1 else cust.mc = ${fld:mc} end)
and 
(case when ${fld:shijian} is null then
	(case when (select code from cc_inleft where customercode = cust.code and org_id = cust.org_id limit 1) is null 
	then cust.indate else (select max(indate) from cc_inleft where customercode = cust.code and org_id = cust.org_id) end)>(now() -'30 day'::INTERVAL) 
	else 1=1 
${filter}
	end)



UNION


select cust.name,(case WHEN cust.sex = '0' then '女' when cust.sex = '1' then '男' else '未知' end) as sex,cust.mobile,
(case when (select enddate from cc_card where customercode=cust.code and isgoon!='-1' and status!=0 and org_id=cust.org_id order by enddate desc limit 1)::date >='${def:date}'
then '有效'  else '无效' end) as status,
(case when (select code from cc_inleft where customercode = cust.code and org_id = cust.org_id limit 1) is null 
	then cust.indate else (select max(indate) from cc_inleft where customercode = cust.code and org_id = cust.org_id) end) as indate,--最后锻炼时间
(NOW()::date-
(case when (select code from cc_inleft where customercode = cust.code and org_id = cust.org_id limit 1) is null 
	then cust.indate else (select max(indate) from cc_inleft where customercode = cust.code and org_id = cust.org_id) end)::date) as tians,
(SELECT hr_staff.name from hr_staff where hr_staff.userlogin=cust.mc) as mc
from (select customercode,max(indate) as indate from cc_inleft GROUP BY customercode) a
left JOIN cc_customer cust on a.customercode=cust.code 
where  cust.org_id=${def:org}  and
(case when ${fld:mc} is null then 1=1 else cust.mc = ${fld:mc} end)
and 
(case when ${fld:shijian} is null then
	(case when (select code from cc_inleft where customercode = cust.code and org_id = cust.org_id limit 1) is null 
	then cust.indate else (select max(indate) from cc_inleft where customercode = cust.code and org_id = cust.org_id) end)>(now() -'30 day'::INTERVAL) 
	else 1=1 ${filter}

	end)

 ORDER BY tians