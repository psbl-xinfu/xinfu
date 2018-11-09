(SELECT
		'否' as ispublic,
		(select  file_path from t_attachment_files where  t_attachment_files.pk_value =r.code and org_id= ${def:org} order by tuid desc limit 1) as img_url,--图片
		r.name as mc_name,
		r.code as mc_code,--会员编号
		(case r.sex when 0 then '女' when 1 then '男' else '未知' end) as i_sex,--性别
		  r.mobile,--电话
		  (select t.domain_text_cn from t_domain t 
		where t.namespace = 'Age' and t.domain_value::int = r.age) as age,--年龄
		  (select hr_staff.name  from hr_staff where hr_staff.userlogin=r.mc and hr_staff.org_id = ${def:org}) as vc_mc,--会籍
		r.indate,-- 入会日期
		d.startdate,--开始日期
		d.enddate,--结束日期
		(select t.tuid from t_attachment_files t where t.pk_value = r.code and t.table_code = 'cc_customer' and t.org_id= ${def:org} order by t.tuid desc limit 1) as imgid,
		COALESCE((select count(*) from cc_comm  where cc_comm.customercode=r.code and cc_comm.org_id=${def:org} group by customercode), 0) as com_count, -- 沟通次数
		(select created from cc_comm  where cc_comm.customercode=r.code and  cc_comm.org_id=${def:org}  order by created desc limit 1) as com_date -- 最新沟通日期
from  cc_customer r 
	inner join cc_card d on r.code=d.customercode and d.isgoon = 0  and d.status!=0  and d.status!=6
	left join cc_inleft l on l.cardcode=d.code and l.org_id=${def:org}
	left join cc_cardtype t on t.code=d.cardtype and t.org_id=${def:org}
where
(case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else r.mc = '${def:user}' end)
AND r.org_id = ${def:org} 
--卡类型
and	(case when ${fld:daochu_f_cardtype} is null then 1=1 else d.cardtype::integer = ${fld:daochu_f_cardtype} end)
--卡状态
AND (
  	case when ${fld:daochu_f_status} is null then 1=1
  	when ${fld:daochu_f_status} = 1 then d.status = 1
  	when ${fld:daochu_f_status} = 2 then d.status = 2
  	when ${fld:daochu_f_status} = 3 then d.status = 3
  	when ${fld:daochu_f_status} = 4 then d.status = 4
  	when ${fld:daochu_f_status} = 5 then d.status = 5
  	when ${fld:daochu_f_status} = 6 then d.status = 6
  	when ${fld:daochu_f_status} = 0 then d.status = 0
  	else true end
  )
--分配次数
and
	(case when ${fld:daochu_f_distributioncount} is null  then 1=1 else 
		(select count(1) from cc_mcchange m 
		where m.customercode = r.code and m.org_id = r.org_id)<${fld:daochu_f_distributioncount}::int
	 end)


 ${filter}
 )
 
 union
 
 (
select
	'是' as ispublic,
	(select  file_path from t_attachment_files where  t_attachment_files.pk_value =r.code and org_id= ${def:org} order by tuid desc limit 1) as img_url,--图片
	r.name as mc_name,
	r.code as mc_code,--会员编号
	(case r.sex when 0 then '女' when 1 then '男' else '未知' end) as i_sex,--性别
	  r.mobile,--电话
	  (select t.domain_text_cn from t_domain t 
	where t.namespace = 'Age' and t.domain_value::int = r.age) as age,--年龄
	  (select hr_staff.name  from hr_staff where hr_staff.userlogin=r.mc and hr_staff.org_id = ${def:org}) as vc_mc,--会籍
	r.indate,-- 入会日期
	(select max(startdate) from cc_card where customercode = r.code and org_id = ${def:org}) as startdate,--开始日期
	(select max(enddate) from cc_card where customercode = r.code and org_id = ${def:org}) as enddate,--结束日期
	(select t.tuid from t_attachment_files t where t.pk_value = r.code and t.table_code = 'cc_customer' and t.org_id= ${def:org} order by t.tuid desc limit 1) as imgid,
	(select count(*) from cc_comm  where cc_comm.customercode=r.code and cc_comm.org_id=${def:org} group by customercode) as com_count, -- 沟通次数
	(select created from cc_comm  where cc_comm.customercode=r.code and  cc_comm.org_id=${def:org}  order by created desc limit 1) as com_date -- 最新沟通日期
FROM cc_public p
inner join cc_customer r on p.customercode = r.code and p.org_id = r.org_id
where p.org_id = ${def:org} and p.status = 0
${filter}
)
 
order by mc_code desc
 
 
 