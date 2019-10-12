select name,sex,mobile,status,indate,mc,cis from (
select  cust.name,(case WHEN cust.sex = '0' then '女' when cust.sex = '1' then '男' else '未知' end) as sex,cust.mobile,
(case when (select enddate from cc_card where customercode=cust.code and isgoon!='-1' and status!=0 and org_id=cust.org_id order by enddate desc limit 1)::date >='2019-04-26'
then '有效'  else '无效' end) as status,
(case when (select code from cc_inleft where customercode = cust.code and org_id = cust.org_id limit 1) is null 
	then cust.indate else (select max(indate) from cc_inleft where customercode = cust.code and org_id = cust.org_id) end) as indate,--最后锻炼时间
(SELECT hr_staff.name from hr_staff where hr_staff.userlogin=cust.mc) as mc,
 (select count(code) from cc_inleft where customercode = cust.code and org_id = cust.org_id   AND indate::date <= ${fld:enddate}::date 
 AND indate::date >= ${fld:startdate}::date
  ) as cis,
  cust.org_id
from cc_customer cust 
where (case when ${fld:mc} is null then 1=1 else cust.mc=${fld:mc} end) and cust.org_id=${def:org}
) as bin

where bin.cis>=${fld:min} and bin.cis<=${fld:max}

order by cis desc