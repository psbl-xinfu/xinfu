 select
 	d.code,
	 d.startdate,	
	 d.enddate,
	 t.name as cardname,
	 d.nowcount,
	 (case when t.type =0 then '时效卡'  when t.type =1 then '计次卡'  when t.type =2 then '基金卡' else '体验卡' end ) as cardtype,
 	(select name from hr_staff where userlogin=(
 		select t.salemember from cc_contract t where t.code = d.contractcode and t.org_id = d.org_id 
 	) and org_id = ${def:org}) as salemember,--销售员
 	
 		 (case when d.status =0 then '无效'  when d.status =1 then '正常'  when d.status =2 then '未启用'
 		 when d.status =3 then '存卡中' when d.status =4 then '挂失中' when d.status =5 then '停卡中'
 		 else '过期' end ) as cardstatus,
 	
 	
 	(select userlogin from hr_staff where userlogin=c.mc and org_id = ${def:org}) as mc--会籍账号
from cc_card d 
left join cc_customer c on c.code = d.customercode and d.org_id = c.org_id 
left join cc_cardtype t on d.cardtype=t.code and t.org_id=${def:org}
where d.customercode = ${fld:customercode}
and c.org_id=${def:org} and d.status!=0 and isgoon=0 and d.status!=6 
