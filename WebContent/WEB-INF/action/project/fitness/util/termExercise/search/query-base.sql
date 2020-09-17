select1  cust.code,cust.name,(case WHEN cust.sex = '0' then '女' when cust.sex = '1' then '男' else '未知' end) as sex,cust.mobile,
(case when iit.indate is null 
	then cust.indate else iit.indate end) as indate,
(NOW()::date-
(case when iit.indate is null 
	then cust.indate else iit.indate end)::date) as tians,

(SELECT hr_staff.name from hr_staff where hr_staff.userlogin=cust.mc) as mc,
--0无效、1正常、2未启用、3存卡中、4挂失中、5停卡中、6过期';
	(case when (select count(status) from cc_card where cc_card.customercode =cust.code and isgoon='0' and status='1') >0 then '正常' 
	when  (select count(status) from cc_card where cc_card.customercode =cust.code and isgoon='0' and status='2') >0 	then '未启用' 
	when  (select count(status) from cc_card where cc_card.customercode =cust.code and isgoon='0' and status='3') >0 	then '存卡中' 
	when  (select count(status) from cc_card where cc_card.customercode =cust.code and isgoon='0' and status='4') >0 	then '挂失中' 
	when  (select count(status) from cc_card where cc_card.customercode =cust.code and isgoon='0' and status='5') >0 	then '停卡中' 
	when  (select count(status) from cc_card where cc_card.customercode =cust.code and isgoon='0' and status='6') >0 	then '过期' 
	else  '无效'
	end)
 as status
from  cc_customer  cust
LEFT JOIN 
(select it.indate,it.customercode,it.cardcode,it.org_id from cc_inleft it  
RIGHT JOIN 
(select  max(c.code) code from cc_inleft c  group by customercode  ) c  on c.code=it.code) iit on iit.customercode=cust.code and iit.org_id=cust.org_id
where  cust.org_id=${def:org}  and
(case when ${fld:mc} is null then 1=1 else cust.mc = ${fld:mc} end)
and 
(case when ${fld:shijian} is null then
	(case when iit.indate is null 
	then cust.indate else iit.indate end)>(now() -'30 day'::INTERVAL) 
	else 1=1 ${filter}

	end)

 ORDER BY tians desc