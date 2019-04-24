SELECT
	concat('<label class="am-checkbox"><input type="checkbox" code2="1" data-am-ucheck name="datalist" code="',(select code from cc_card where customercode=r.code and isgoon=0 and org_id=${def:org} order by enddate desc limit 1) ,'" value="',r.code,'','" ></label>') as application,
		(select  file_path from t_attachment_files where  t_attachment_files.pk_value =r.code and org_id= ${def:org} order by tuid desc limit 1) as img_url,--图片
		r.name as mc_name,
		r.code as mc_code,--会员编号
		(case r.sex when 0 then '女' when 1 then '男' else '未知' end) as i_sex,--性别
		 	(case when
				((select enddate from cc_card where isgoon=0 and org_id=1038 and customercode=r.code order by enddate desc limit 1)::date - now()::date)>0 
	then concat('剩余',((select enddate from cc_card where isgoon=0 and org_id=1038 and customercode=r.code order by enddate desc limit 1)::date - now()::date),'天')
			when ((select enddate from cc_card where isgoon=0 and org_id=1038 and customercode=r.code order by enddate desc limit 1)::date - now()::date)<=0 
	then concat('已过期',(now()::date - (select enddate from cc_card where isgoon=0 and org_id=1038 and customercode=r.code order by enddate desc limit 1)::date),'天')
	when ((select enddate from cc_card where isgoon=0 and org_id=1038 and customercode=r.code order by enddate desc limit 1)::date - now()::date) is null 
	then '未启用'
end) as custday,--会员有效期（天数）
		  (select t.domain_text_cn from t_domain t 
		where t.namespace = 'Age' and t.domain_value::int = r.age) as age,--年龄
		  (select hr_staff.name  from hr_staff where hr_staff.userlogin=r.mc and hr_staff.org_id = ${def:org}) as vc_mc,--会籍
		(select t.tuid from t_attachment_files t where t.pk_value = r.code and t.table_code = 'cc_customer' and t.org_id= ${def:org} order by t.tuid desc limit 1) as imgid,
		(select created from cc_comm  where cc_comm.customercode=r.code and  cc_comm.org_id=${def:org}  order by created desc limit 1) as com_date, -- 最新沟通日期
		(select indate from cc_inleft  where customercode=r.code and org_id=${def:org}  order by indate desc limit 1) as in_date,--最近入场日期
		p.entertime,--最新分配日期
		(case when
		(p.grabtime::date+(${fld:period_day}||'day')::interval)::date - now()::date >= 0 then '否'
		when (p.grabtime::date+(${fld:period_day}||'day')::interval)::date - now()::date < 0 then '是'
		end) as is_public,--是否进入公海
	 	(case when (p.grabtime::date+(${fld:period_day}||'day')::interval)::date - now()::date < 0
		then concat('已过期', now()::date-(p.grabtime::date+(${fld:period_day}||'day')::interval)::date,'天')
		when (p.grabtime::date+(${fld:period_day}||'day')::interval)::date - now()::date >= 0
		then concat('未过期', (p.grabtime::date+(${fld:period_day}||'day')::interval)::date - now()::date ,'天')
		end) as num_days --保护期天数
from  cc_customer r 
left join cc_public p on p.customercode=r.code
where
(case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else r.mc = '${def:user}' end)
			and exists(select 1 from cc_card where org_id=${def:org} and isgoon=0 )
and r.status!=0  
AND r.org_id = ${def:org} 
${filter}
  order by p.grabtime desc
 
 
 
 