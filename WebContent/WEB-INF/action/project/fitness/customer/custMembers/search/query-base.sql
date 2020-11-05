select name,sex,mobile,status,indate,mc,cis,enddate,code,typename,sycs from (


select  cust.name,(case WHEN cust.sex = '0' then '女' when cust.sex = '1' then '男' else '未知' end) as sex,cust.mobile,

(case cd.status 
WHEN '1' then '正常' 
WHEN '2' then '未启用'
WHEN '3' then '存卡中'
WHEN '4' then '挂失中'
WHEN '5' then '停卡中'
WHEN '6' then '过期'
else '无效' end) as status,
ct.name as typename,
cd.enddate,
cd.code,
(case ct.type::VARCHAR when '1' then cd.nowcount::VARCHAR else '无限' end)  as sycs,
(case when (select code from cc_inleft where customercode = cust.code and org_id = cust.org_id limit 1) is null 
	then cust.indate else (select max(indate) from cc_inleft where customercode = cust.code and org_id = cust.org_id) end) as indate,--最后锻炼时间
(SELECT hr_staff.name from hr_staff where hr_staff.userlogin=cust.mc) as mc,
 (select count(code) from cc_inleft where customercode = cust.code and org_id = cust.org_id   AND indate::date <= ${fld:enddate}::date 
 AND indate::date >= ${fld:startdate}::date
  ) as cis,
  cust.org_id
from cc_customer cust 
RIGHT join cc_card cd on cd.customercode=cust.code and cd.isgoon=0
left join cc_cardtype ct on ct.code=cd.cardtype 
where (case when ${fld:mc} is null then 1=1 else cust.mc=${fld:mc} end) and cust.org_id=${def:org}
) as bin

where bin.cis>=${fld:min} and bin.cis<=${fld:max}
${filter}
order by cis desc


