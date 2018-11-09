select 
	guest.code,
	(select name from hr_staff whereuserlogin = 
	(select followby from cc_return_log where custtype = 0 and pk_value = guest.code and org_id = ${def:org} order by created desc limit 1)) as kefu,
	concat('<input type="checkbox" class="custcomm" code2="2" name="custcomm" value="', guest.code, '" code="0" code1="0" codedatatype="0">') as application_id,
	'资源' as custtypename,
	guest.name,
	(case when guest.sex=0 then '女' when guest.sex=1 then '男' else '未知' end) as sex,
	guest.age,
	guest.mobile,
	'' as pt,--私教
	(select (select name from hr_staff where userlogin = cc_comm.createdby) 
		from cc_comm 
		inner join (select commcode from cc_return_log where org_id = ${def:org} 
		and to_char(created, 'yyyy-MM')=to_char('${def:date}'::date, 'yyyy-MM')
		and custtype=0 and pk_value=guest.code) rl on rl.commcode = cc_comm.code
		where org_id = ${def:org}) as mc,--会籍
	'到访未成交' as specialtype,
	'' as level,
	(case when (select count(1) from cc_comm 
		inner join (select commcode from cc_return_log where org_id = ${def:org} 
		and to_char(created, 'yyyy-MM')=to_char('${def:date}'::date, 'yyyy-MM')
		and custtype=0 and pk_value=guest.code) rl on rl.commcode = cc_comm.code
		where operatortype=0 and org_id = ${def:org})>0
		then '已跟进' else '未跟进'
	end) as mcstatus,
	(case when (select count(1) from cc_comm 
		inner join (select commcode from cc_return_log where org_id = ${def:org} 
		and to_char(created, 'yyyy-MM')=to_char('${def:date}'::date, 'yyyy-MM')
		and custtype=0 and pk_value=guest.code) rl on rl.commcode = cc_comm.code
		where operatortype=1 and org_id = ${def:org})>0
		then '已跟进' else '未跟进'
	end) as ptstatus,
	'' as ptdate,--私教最后跟进时间
	(select created::date from cc_comm 
		inner join (select commcode from cc_return_log where org_id = ${def:org} 
		and to_char(created, 'yyyy-MM')=to_char('${def:date}'::date, 'yyyy-MM')
		and custtype=0 and pk_value=guest.code) rl on rl.commcode = cc_comm.code
		where org_id = ${def:org})::varchar as mcdate--会籍最后跟进时间
from cc_guest guest
where guest.status=1 and guest.org_id = ${def:org}
and (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else exists(
				(select 1 from cc_return_log where custtype = 0 
				and pk_value = guest.code and org_id = ${def:org} 
				and  followby = '${def:user}'
				order by created desc limit 1)
			) end)
and (case when ${fld:daochu_custtype} is null then 1=1 else '2'=${fld:daochu_custtype} end)
and (case when ${fld:daochu_specialtype} is null then 1=1 else '0'=${fld:daochu_specialtype} end)
--回访状态
and (case when ${fld:daochu_f_returntype} is null then 1=1 
	when ${fld:daochu_f_returntype}='0' then 
	exists(
		select 1 from cc_return_log where org_id = ${def:org}
		and custtype=0 and coMMcode is not null and coMMcode!=''
		and pk_value = guest.code
	)
	when ${fld:daochu_f_returntype}='1' then 
	exists(
		select 1 from cc_return_log where org_id = ${def:org}
		and custtype=0 and (coMMcode is null or coMMcode='')
		and pk_value = guest.code
	)
end)
--本月未回访
and (case when ${fld:daochu_thismonthtypeone} is null then 1=1 else exists(
			select 1 from cc_return_log where org_id = ${def:org}
			and custtype=0 and (coMMcode is null or coMMcode='')
			and to_char(created, 'yyyy-MM')=to_char('${def:date}'::date, 'yyyy-MM')
			and pk_value = guest.code
		) end)
--本月分配
and (case when ${fld:daochu_thismonthtypetwo} is null then 1=1 else exists(
				select 1 from cc_return_log where org_id = ${def:org}
				and custtype=0
				and to_char(created, 'yyyy-MM')=to_char('${def:date}'::date, 'yyyy-MM')
				and pk_value = guest.code
			) end)
			
/*-------------------------筛选-------------------------------------*/
--性别
and (case when ${fld:daochu_f_sex} is null then 1=1 else exists(
				select 1 from cc_guest where org_id = ${def:org}
				and guest.sex=${fld:daochu_f_sex}
			) end)

--会籍
and (case when ${fld:daochu_f_mc} is null then 1=1 else exists(
				select 1 from cc_guest where org_id = ${def:org}
				and guest.mc=${fld:daochu_f_mc}
			) end)

--私教
and (case when ${fld:daochu_f_pt} is null then 1=1 else false end)
			
--沟通阶段
and (case when ${fld:daochu_f_stage} is null then 1=1 else exists(
				select 1 from cc_comm where cust_type=0
				and stage=${fld:daochu_f_stage}
				and guestcode=guest.code
			) end)

--年龄段
and (case when ${fld:daochu_f_age} is null then 1=1 else exists(
				select 1 from cc_guest where org_id = ${def:org}
				and guest.age=${fld:daochu_f_age}
			) end)	
--通话次数
and (case when ${fld:daochu_f_calltimes} is null then 1=1 else exists(
				select 1 from cc_comm where cust_type=0
				and (select count(customercode)  from cc_comm where guestcode=guest.code)<${fld:daochu_f_calltimes}
			) end)	
			
--未续费原因
and (case when ${fld:daochu_f_leave} is null then 1=1 else false end)
			
--未跟进天数
and (case when ${fld:daochu_f_unfollow} is null then 1=1 else exists(
				select 1 from cc_comm where cust_type=0
				and  (select Date(to_char(created,'yyyy-MM-DD'))-Date(to_char('${def:date}'::date,'yyyy-MM-DD')) from cc_comm where guestcode=guest.code order by created DESC LIMIT 1)
					<${fld:daochu_f_unfollow}
			) end)
--会籍关注度
and (case when ${fld:daochu_f_mc_status} is null then 1=1 else exists(
				select 1 from cc_comm where cust_type=0
				and  level=${fld:daochu_f_mc_status}
				and  operatortype=0 and guestcode = guest.code
			) end)	
			
--私教关注度
and (case when ${fld:daochu_f_pt_status} is null then 1=1 else exists(
				select 1 from cc_comm where cust_type=0
				and  level=${fld:daochu_f_pt_status}
				and  operatortype=1 and guestcode = guest.code
			) end)	
--生日
and (case when ${fld:daochu_f_startmonth} is null then 1=1 else guest.birth::int>=${fld:daochu_f_startmonth}::int end)
and (case when ${fld:daochu_f_startday} is null then 1=1 else guest.birthday::int>=${fld:daochu_f_startday}::int end)
and (case when ${fld:daochu_f_endmonth} is null then 1=1 else guest.birth::int<=${fld:daochu_f_endmonth}::int end)
and (case when ${fld:daochu_f_endday} is null then 1=1 else guest.birthday::int<=${fld:daochu_f_endday}::int end)

--是否参加过俱乐部
and (case when ${fld:daochu_f_participate} is null then 1=1 else guest.participate = ${fld:daochu_f_participate} end)
--是否曾是本俱乐部会员
and (case when ${fld:daochu_f_ismember} is null then 1=1 else guest.ismember = ${fld:daochu_f_ismember} end)
--健身目的
and (case when ${fld:daochu_f_purpose} is null then 1=1 else guest.purpose = ${fld:daochu_f_purpose} end)
--个人爱好
and (case when ${fld:daochu_f_personalhobbit} is null then 1=1 else guest.personalhobbit = ${fld:daochu_f_personalhobbit} end)
--婚姻情况
and (case when ${fld:daochu_f_marriage} is null then 1=1 else guest.marriage = ${fld:daochu_f_marriage} end)
--子女情况
and (case when ${fld:daochu_f_children} is null then 1=1 else guest.children = ${fld:daochu_f_children} end)

--0会员1资源
and (case when ${fld:daochu_f_custtype} is null then 1=1 
		when ${fld:daochu_f_custtype}='0' then 1=1
		when ${fld:daochu_f_custtype}='1' then 1=2 
	end) 
--录入日期
and (case when ${fld:daochu_startdate} is null then 1=1 else guest.created >= ${fld:daochu_startdate} end)
--录入日期
and (case when ${fld:daochu_enddate} is null then 1=1 else guest.created <= ${fld:daochu_enddate} end)

------------------------------------------------*/

union
--一月之内要过期不续费的会员
select 
	cust.code,
	(select name from hr_staff where userlogin = 
	(select followby from cc_return_log where custtype = 1 and pk_value = cust.code and org_id = ${def:org} order by created desc limit 1)) as kefu,
	concat('<input type="checkbox" class="custcomm" code2="1" name="custcomm" value="', cust.code, '" code="1" code1="1" codedatatype="1">') as application_id,
	'会员' as custtypename,
	cust.name,
	(case when cust.sex=0 then '女' when cust.sex=1 then '男' else '未知' end) as sex,
	cust.age,
	cust.mobile,
	'' as pt,--私教
	(select (select name from hr_staff where userlogin = cc_comm.createdby) from cc_comm 
		inner join (select commcode from cc_return_log where org_id = ${def:org} 
		and to_char(created, 'yyyy-MM')=to_char('${def:date}'::date, 'yyyy-MM')
		and custtype=1 and pk_value=cust.code) rl on rl.commcode = cc_comm.code
	where org_id = ${def:org}) as mc,--会籍
	'过期未续费' as specialtype,
	'' as level,
	(case when (select count(1) from cc_comm 
		inner join (select commcode from cc_return_log where org_id = ${def:org} 
		and to_char(created, 'yyyy-MM')=to_char('${def:date}'::date, 'yyyy-MM')
		and custtype=1 and pk_value=cust.code) rl on rl.commcode = cc_comm.code
		where operatortype=0 and org_id = ${def:org})>0
		then '已跟进' else '未跟进'
	end) as mcstatus,
	(case when (select count(1) from cc_comm 
		inner join (select commcode from cc_return_log where org_id = ${def:org} 
		and to_char(created, 'yyyy-MM')=to_char('${def:date}'::date, 'yyyy-MM')
		and custtype=1 and pk_value=cust.code) rl on rl.commcode = cc_comm.code
		where operatortype=1 and org_id = ${def:org})>0
		then '已跟进' else '未跟进'
	end) as ptstatus,
	'' as ptdate,--私教最后跟进时间
	(select created::date from cc_comm 
		inner join (select commcode from cc_return_log where org_id = ${def:org} 
		and to_char(created, 'yyyy-MM')=to_char('${def:date}'::date, 'yyyy-MM')
		and custtype=1 and pk_value=cust.code) rl on rl.commcode = cc_comm.code
		where org_id = ${def:org})::varchar as mcdate--会籍最后跟进时间
from cc_customer cust
where cust.org_id = ${def:org} 
and (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else exists(
				(select 1 from cc_return_log where custtype = 0 
				and pk_value = cust.code and org_id = ${def:org} 
				and  followby = '${def:user}'
				order by created desc limit 1)
			) end)
and 30 >= (
	select max(d.enddate) from cc_card d where d.isgoon=0 and d.org_id = cust.org_id 
	and d.customercode = cust.code 
	and d.status !=0 and d.status!=6 
	and d.enddate is not null 
) - {d '${def:date}'} 
and not exists(
	select 1 from cc_card d2 where
	d2.customercode = cust.code  and d2.isgoon=1
) 
and (case when ${fld:daochu_custtype} is null then 1=1 else '1'=${fld:daochu_custtype} end)
and (case when ${fld:daochu_specialtype} is null then 1=1 else '1'=${fld:daochu_specialtype} end)
--回访状态
and (case when ${fld:daochu_f_returntype} is null then 1=1 
	when ${fld:daochu_f_returntype}='0' then 
	exists(
		select 1 from cc_return_log where org_id = ${def:org}
		and custtype=1 and coMMcode is not null and coMMcode!=''
		and pk_value = cust.code
	)
	when ${fld:daochu_f_returntype}='1' then 
	exists(
		select 1 from cc_return_log where org_id = ${def:org}
		and custtype=1 and (coMMcode is null or coMMcode='')
		and pk_value = cust.code
	)
end)

--本月未回访
and (case when ${fld:daochu_thismonthtypeone} is null then 1=1 else exists(
				select 1 from cc_return_log where org_id = ${def:org}
				and custtype=1 and (coMMcode is null or coMMcode='')
				and to_char(created, 'yyyy-MM')=to_char('${def:date}'::date, 'yyyy-MM')
				and pk_value = cust.code
			) end)
--本月分配
and (case when ${fld:daochu_thismonthtypetwo} is null then 1=1 else exists(
				select 1 from cc_return_log where org_id = ${def:org}
				and custtype=1
				and to_char(created, 'yyyy-MM')=to_char('${def:date}'::date, 'yyyy-MM')
				and pk_value = cust.code
			) end)
			
/*-------------------------筛选-------------------------------------*/
--性别
and (case when ${fld:daochu_f_sex} is null then 1=1 else exists(
				select 1 from cc_customer where org_id = ${def:org}
				and cust.sex=${fld:daochu_f_sex}
			) end)
--会籍
and (case when ${fld:daochu_f_mc} is null then 1=1 else exists(
				select 1 from cc_customer where org_id = ${def:org}
				and cust.mc=${fld:daochu_f_mc}
			) end)
--私教
and (case when ${fld:daochu_f_pt} is null then 1=1 else exists(
				select 1 from cc_customer where org_id = ${def:org}
				and cust.pt=${fld:daochu_f_pt}
			) end)
--沟通阶段
and (case when ${fld:daochu_f_stage} is null then 1=1 else exists(
				select 1 from cc_comm where cust_type=1
				and stage=${fld:daochu_f_stage}
			) end)
--未续费原因
and (case when ${fld:daochu_f_leave} is null then 1=1 else exists(
				select 1 from cc_customer where org_id = ${def:org}
				and cust.leave=${fld:daochu_f_leave}
			) end)
--年龄段
and (case when ${fld:daochu_f_age} is null then 1=1 else exists(
				select 1 from cc_customer where org_id = ${def:org}
				and cust.age=${fld:daochu_f_age}
			) end)	
--通话次数
and (case when ${fld:daochu_f_calltimes} is null then 1=1 else exists(
				select 1 from cc_comm where cust_type=1
				and (select count(customercode)  from cc_comm where customercode=cust.code)<${fld:daochu_f_calltimes}
			) end)	
--未跟进天数
and (case when ${fld:daochu_f_unfollow} is null then 1=1 else exists(
				select 1 from cc_comm where cust_type=1
				and  (select Date(to_char(created,'yyyy-MM-DD'))-Date(to_char('${def:date}'::date,'yyyy-MM-DD')) from cc_comm where customercode=cust.code order by created DESC LIMIT 1)
					<${fld:daochu_f_unfollow}
			) end)	
--会籍关注度
and (case when ${fld:daochu_f_mc_status} is null then 1=1 else exists(
				select 1 from cc_comm where cust_type=1
				and  level=${fld:daochu_f_mc_status}
				and  operatortype=0 and customercode = cust.code
			) end)	
			
--私教关注度
and (case when ${fld:daochu_f_pt_status} is null then 1=1 else exists(
				select 1 from cc_comm where cust_type=1
				and  level=${fld:daochu_f_pt_status}
				and  operatortype=1 and customercode = cust.code
			) end)	
--生日
and (case when ${fld:daochu_f_startmonth} is null then 1=1 else cust.birth::int>=${fld:daochu_f_startmonth}::int end)
and (case when ${fld:daochu_f_startday} is null then 1=1 else cust.birthday::int>=${fld:daochu_f_startday}::int end)
and (case when ${fld:daochu_f_endmonth} is null then 1=1 else cust.birth::int<=${fld:daochu_f_endmonth}::int end)
and (case when ${fld:daochu_f_endday} is null then 1=1 else cust.birthday::int<=${fld:daochu_f_endday}::int end)

--健身目的
and (case when ${fld:daochu_f_purpose} is null then 1=1 else cust.purpose = ${fld:daochu_f_purpose} end)
--个人爱好
and (case when ${fld:daochu_f_personalhobbit} is null then 1=1 else cust.personalhobbit = ${fld:daochu_f_personalhobbit} end)
--婚姻情况
and (case when ${fld:daochu_f_marriage} is null then 1=1 else cust.marriage = ${fld:daochu_f_marriage} end)
--子女情况
and (case when ${fld:daochu_f_children} is null then 1=1 else cust.children = ${fld:daochu_f_children} end)

--0会员1资源
and (case when ${fld:daochu_f_custtype} is null then 1=1 
		when ${fld:daochu_f_custtype}='0' then 1=2
		when ${fld:daochu_f_custtype}='1' then 1=1 
	end) 
--录入日期
and (case when ${fld:daochu_startdate} is null then 1=1 else cust.created >= ${fld:daochu_startdate} end)
--录入日期
and (case when ${fld:daochu_enddate} is null then 1=1 else cust.created <= ${fld:daochu_enddate} end)

/*-----------------------------------------------------------------*/

union
--过期续费的会员
select 
	cust.code,
	(select name from hr_staff where userlogin = 
	(select followby from cc_return_log where custtype = 1 and pk_value = cust.code and org_id = ${def:org} order by created desc limit 1)) as kefu,
	concat('<input type="checkbox" class="custcomm" code2="1" name="custcomm" value="', cust.code, '" code="1" code1="1" codedatatype="1">') as application_id,
	'会员' as custtypename,
	cust.name,
	(case when cust.sex=0 then '女' when cust.sex=1 then '男' else '未知' end) as sex,
	cust.age,
	cust.mobile,
	'' as pt,--私教
	(select (select name from hr_staff where userlogin = cc_comm.createdby) from cc_comm 
		inner join (select commcode from cc_return_log where org_id = ${def:org} 
		and to_char(created, 'yyyy-MM')=to_char('${def:date}'::date, 'yyyy-MM')
		and custtype=1 and pk_value=cust.code) rl on rl.commcode = cc_comm.code
		where org_id = ${def:org}) as mc,--会籍
	'过期未续费' as specialtype,
	'' as level,
	(case when (select count(1) from cc_comm 
		inner join (select commcode from cc_return_log where org_id = ${def:org} 
		and to_char(created, 'yyyy-MM')=to_char('${def:date}'::date, 'yyyy-MM')
		and custtype=1 and pk_value=cust.code) rl on rl.commcode = cc_comm.code
		where org_id = ${def:org})>0
		then '已跟进' else '未跟进'
	end) as mcstatus,
	(case when (select count(1) from cc_comm 
		inner join (select commcode from cc_return_log where org_id = ${def:org} 
		and to_char(created, 'yyyy-MM')=to_char('${def:date}'::date, 'yyyy-MM')
		and custtype=1 and pk_value=cust.code) rl on rl.commcode = cc_comm.code
		where operatortype=1 and org_id = ${def:org})>0
		then '已跟进' else '未跟进'
	end) as ptstatus,
	'' as ptdate,--私教最后跟进时间
	(select created::date from cc_comm
		inner join (select commcode from cc_return_log where org_id = ${def:org} 
		and to_char(created, 'yyyy-MM')=to_char('${def:date}'::date, 'yyyy-MM')
		and custtype=1 and pk_value=cust.code) rl on rl.commcode = cc_comm.code
		where org_id = ${def:org})::varchar as mcdate--会籍最后跟进时间
from cc_customer cust
where cust.org_id = ${def:org} 
and (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else exists(
				(select 1 from cc_return_log where custtype = 0 
				and pk_value = cust.code and org_id = ${def:org} 
				and  followby = '${def:user}'
				order by created desc limit 1)
			) end)
and not exists(
	select 1 from cc_card d where d.isgoon=0 and d.org_id = cust.org_id 
	and d.customercode = cust.code 
	and d.status !=0 and d.status!=6 
) 
and not exists(
	select 1 from cc_card d2 where 
	d2.customercode = cust.code  and d2.isgoon=1
) 
and (case when ${fld:daochu_custtype} is null then 1=1 else '1'=${fld:daochu_custtype} end)
and (case when ${fld:daochu_specialtype} is null then 1=1 else '1'=${fld:daochu_specialtype} end)
--回访状态
and (case when ${fld:daochu_f_returntype} is null then 1=1 
	when ${fld:daochu_f_returntype}='0' then 
	exists(
		select 1 from cc_return_log where org_id = ${def:org}
		and custtype=1 and coMMcode is not null and coMMcode!=''
		and pk_value = cust.code
	)
	when ${fld:daochu_f_returntype}='1' then 
	exists(
		select 1 from cc_return_log where org_id = ${def:org}
		and custtype=1 and (coMMcode is null or coMMcode='')
		and pk_value = cust.code
	)
end)

--本月未回访
and (case when ${fld:daochu_thismonthtypeone} is null then 1=1 else exists(
				select 1 from cc_return_log where org_id = ${def:org}
				and custtype=1 and (coMMcode is null or coMMcode='')
				and to_char(created, 'yyyy-MM')=to_char('${def:date}'::date, 'yyyy-MM')
				and pk_value = cust.code
			) end)
--本月分配
and (case when ${fld:daochu_thismonthtypetwo} is null then 1=1 else exists(
				select 1 from cc_return_log where org_id = ${def:org}
				and custtype=1
				and to_char(created, 'yyyy-MM')=to_char('${def:date}'::date, 'yyyy-MM')
				and pk_value = cust.code
			) end)
			
/*-------------------------筛选-------------------------------------*/
--性别
and (case when ${fld:daochu_f_sex} is null then 1=1 else exists(
				select 1 from cc_customer where org_id = ${def:org}
				and cust.sex=${fld:daochu_f_sex}
			) end)
--会籍
and (case when ${fld:daochu_f_mc} is null then 1=1 else exists(
				select 1 from cc_customer where org_id = ${def:org}
				and cust.mc=${fld:daochu_f_mc}
			) end)
--私教
and (case when ${fld:daochu_f_pt} is null then 1=1 else exists(
				select 1 from cc_customer where org_id = ${def:org}
				and cust.pt=${fld:daochu_f_pt}
			) end)
--沟通阶段
and (case when ${fld:daochu_f_stage} is null then 1=1 else exists(
				select 1 from cc_comm where cust_type=1
				and stage=${fld:daochu_f_stage}
			) end)
--未续费原因
and (case when ${fld:daochu_f_leave} is null then 1=1 else exists(
				select 1 from cc_customer where org_id = ${def:org}
				and cust.leave=${fld:daochu_f_leave}
			) end)
--年龄段
and (case when ${fld:daochu_f_age} is null then 1=1 else exists(
				select 1 from cc_customer where org_id = ${def:org}
				and cust.age=${fld:daochu_f_age}
			) end)	
--通话次数
and (case when ${fld:daochu_f_calltimes} is null then 1=1 else exists(
				select 1 from cc_comm where cust_type=1
				and (select count(customercode)  from cc_comm where customercode=cust.code)<${fld:daochu_f_calltimes}
			) end)	
--未跟进天数
and (case when ${fld:daochu_f_unfollow} is null then 1=1 else exists(
				select 1 from cc_comm where cust_type=1
				and  (select Date(to_char(created,'yyyy-MM-DD'))-Date(to_char('${def:date}'::date,'yyyy-MM-DD')) from cc_comm where customercode=cust.code order by created DESC LIMIT 1)
					<${fld:daochu_f_unfollow}
			) end)	
--会籍关注度
and (case when ${fld:daochu_f_mc_status} is null then 1=1 else exists(
				select 1 from cc_comm where cust_type=1
				and  level=${fld:daochu_f_mc_status}
				and  operatortype=0 and customercode = cust.code
			) end)	
			
--私教关注度
and (case when ${fld:daochu_f_pt_status} is null then 1=1 else exists(
				select 1 from cc_comm where cust_type=1
				and  level=${fld:daochu_f_pt_status}
				and  operatortype=1 and customercode = cust.code
			) end)	
--生日
and (case when ${fld:daochu_f_startmonth} is null then 1=1 else cust.birth::int>=${fld:daochu_f_startmonth}::int end)
and (case when ${fld:daochu_f_startday} is null then 1=1 else cust.birthday::int>=${fld:daochu_f_startday}::int end)
and (case when ${fld:daochu_f_endmonth} is null then 1=1 else cust.birth::int<=${fld:daochu_f_endmonth}::int end)
and (case when ${fld:daochu_f_endday} is null then 1=1 else cust.birthday::int<=${fld:daochu_f_endday}::int end)

--健身目的
and (case when ${fld:daochu_f_purpose} is null then 1=1 else cust.purpose = ${fld:daochu_f_purpose} end)
--个人爱好
and (case when ${fld:daochu_f_personalhobbit} is null then 1=1 else cust.personalhobbit = ${fld:daochu_f_personalhobbit} end)
--婚姻情况
and (case when ${fld:daochu_f_marriage} is null then 1=1 else cust.marriage = ${fld:daochu_f_marriage} end)
--子女情况
and (case when ${fld:daochu_f_children} is null then 1=1 else cust.children = ${fld:daochu_f_children} end)

--0会员1资源
and (case when ${fld:daochu_f_custtype} is null then 1=1 
		when ${fld:daochu_f_custtype}='0' then 1=2
		when ${fld:daochu_f_custtype}='1' then 1=1 
	end) 
--录入日期
and (case when ${fld:daochu_startdate} is null then 1=1 else cust.created >= ${fld:daochu_startdate} end)
--录入日期
and (case when ${fld:daochu_enddate} is null then 1=1 else cust.created <= ${fld:daochu_enddate} end)

	
/*-----------------------------------------------------------------*/

union

select 
	cust.code,
	(select name from hr_staff where userlogin = 
	(select followby from cc_return_log where custtype = 1 and pk_value = cust.code and org_id = ${def:org} order by created desc limit 1)) as kefu,
	concat('<input type="checkbox" class="custcomm" code2="1" name="custcomm" value="', cust.code, '" code="1" code1="2" codedatatype="2">') as application_id,
	'会员' as custtypename,
	cust.name,
	(case when cust.sex=0 then '女' when cust.sex=1 then '男' else '未知' end) as sex,
	cust.age,
	cust.mobile,
	(select (select name from hr_staff where userlogin = cc_comm.createdby) from cc_comm where code = (select commcode from cc_return_log where org_id = ${def:org} 
		and to_char(created, 'yyyy-MM')=to_char('${def:date}'::date, 'yyyy-MM')
		and custtype=1 and pk_value=cust.code) and org_id = ${def:org}) as pt,--私教
	'' as mc,--会籍
	'私教预约未成功' as specialtype,
	'' as level,
	(case when (select count(1) from cc_comm 
		inner join (select commcode from cc_return_log where org_id = ${def:org} 
		and to_char(created, 'yyyy-MM')=to_char('${def:date}'::date, 'yyyy-MM')
		and custtype=1 and pk_value=cust.code) rl on rl.commcode = cc_comm.code
		where operatortype=0 and org_id = ${def:org})>0
		then '已跟进' else '未跟进'
	end) as mcstatus,
	(case when (select count(1) from cc_comm 
		inner join (select commcode from cc_return_log where org_id = ${def:org} 
		and to_char(created, 'yyyy-MM')=to_char('${def:date}'::date, 'yyyy-MM')
		and custtype=1 and pk_value=cust.code) rl on rl.commcode = cc_comm.code
		where operatortype=1 and org_id = ${def:org})>0
		then '已跟进' else '未跟进'
	end) as ptstatus,
	(select created::date from cc_comm 
		inner join (select commcode from cc_return_log where org_id = ${def:org} 
		and to_char(created, 'yyyy-MM')=to_char('${def:date}'::date, 'yyyy-MM')
		and custtype=1 and pk_value=cust.code) rl on rl.commcode = cc_comm.code
		where org_id = ${def:org})::varchar as ptdate,--私教最后跟进时间
	'' as mcdate--会籍私教最后跟进时间
from cc_customer cust
where cust.org_id = ${def:org} 
and (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else exists(
				(select 1 from cc_return_log where custtype = 0 
				and pk_value = cust.code and org_id = ${def:org} 
				and  followby = '${def:user}'
				order by created desc limit 1)
			) end)
and exists(
	select 1 from cc_card where status!=0 and status!=6 and isgoon=0
	and cust.code = customercode and org_id = cust.org_id
)
and not exists(
	select 1 from cc_ptrest where org_id = cust.org_id
	and pttype!=5
	and cust.code =customercode
)
and (case when ${fld:daochu_custtype} is null then 1=1 else '1'=${fld:daochu_custtype} end)
and (case when ${fld:daochu_specialtype} is null then 1=1 else '2'=${fld:daochu_specialtype} end)
--回访状态
and (case when ${fld:daochu_f_returntype} is null then 1=1 
	when ${fld:daochu_f_returntype}='0' then 
	exists(
		select 1 from cc_return_log where org_id = ${def:org}
		and custtype=1 and coMMcode is not null and coMMcode!=''
		and pk_value = cust.code
	)
	when ${fld:daochu_f_returntype}='1' then 
	exists(
		select 1 from cc_return_log where org_id = ${def:org}
		and custtype=1 and (coMMcode is null or coMMcode='')
		and pk_value = cust.code
	)
end)
--本月未回访
and (case when ${fld:daochu_thismonthtypeone} is null then 1=1 else exists(
				select 1 from cc_return_log where org_id = ${def:org}
				and custtype=1 and (coMMcode is null or coMMcode='')
				and to_char(created, 'yyyy-MM')=to_char('${def:date}'::date, 'yyyy-MM')
				and pk_value = cust.code
			) end)
--本月分配
and (case when ${fld:daochu_thismonthtypetwo} is null then 1=1 else exists(
				select 1 from cc_return_log where org_id = ${def:org}
				and custtype=1
				and to_char(created, 'yyyy-MM')=to_char('${def:date}'::date, 'yyyy-MM')
				and pk_value = cust.code
			) end)

			
/*-------------------------筛选-------------------------------------*/
--性别
and (case when ${fld:daochu_f_sex} is null then 1=1 else exists(
				select 1 from cc_customer where org_id = ${def:org}
				and cust.sex=${fld:daochu_f_sex}
			) end)
--会籍
and (case when ${fld:daochu_f_mc} is null then 1=1 else exists(
				select 1 from cc_customer where org_id = ${def:org}
				and cust.mc=${fld:daochu_f_mc}
			) end)
--私教
and (case when ${fld:daochu_f_pt} is null then 1=1 else exists(
				select 1 from cc_customer where org_id = ${def:org}
				and cust.pt=${fld:daochu_f_pt}
			) end)
--沟通阶段
and (case when ${fld:daochu_f_stage} is null then 1=1 else exists(
				select 1 from cc_comm where cust_type=1
				and stage=${fld:daochu_f_stage}
			) end)
--未续费原因
and (case when ${fld:daochu_f_leave} is null then 1=1 else exists(
				select 1 from cc_customer where org_id = ${def:org}
				and cust.leave=${fld:daochu_f_leave}
			) end)
--年龄段
and (case when ${fld:daochu_f_age} is null then 1=1 else exists(
				select 1 from cc_customer where org_id = ${def:org}
				and cust.age=${fld:daochu_f_age}
			) end)	
--通话次数
and (case when ${fld:daochu_f_calltimes} is null then 1=1 else exists(
				select 1 from cc_comm where cust_type=1
				and (select count(customercode)  from cc_comm where customercode=cust.code)<${fld:daochu_f_calltimes}
			) end)	
--未跟进天数
and (case when ${fld:daochu_f_unfollow} is null then 1=1 else exists(
				select 1 from cc_comm where cust_type=1
				and  (select Date(to_char(created,'yyyy-MM-DD'))-Date(to_char('${def:date}'::date,'yyyy-MM-DD')) from cc_comm where customercode=cust.code order by created DESC LIMIT 1)
					<${fld:daochu_f_unfollow}
			) end)	
--会籍关注度
and (case when ${fld:daochu_f_mc_status} is null then 1=1 else exists(
				select 1 from cc_comm where cust_type=1
				and  level=${fld:daochu_f_mc_status}
				and  operatortype=0 and customercode = cust.code
			) end)	
			
--私教关注度
and (case when ${fld:daochu_f_pt_status} is null then 1=1 else exists(
				select 1 from cc_comm where cust_type=1
				and  level=${fld:daochu_f_pt_status}
				and  operatortype=1 and customercode = cust.code
			) end)	
--生日
and (case when ${fld:daochu_f_startmonth} is null then 1=1 else cust.birth::int>=${fld:daochu_f_startmonth}::int end)
and (case when ${fld:daochu_f_startday} is null then 1=1 else cust.birthday::int>=${fld:daochu_f_startday}::int end)
and (case when ${fld:daochu_f_endmonth} is null then 1=1 else cust.birth::int<=${fld:daochu_f_endmonth}::int end)
and (case when ${fld:daochu_f_endday} is null then 1=1 else cust.birthday::int<=${fld:daochu_f_endday}::int end)

--健身目的
and (case when ${fld:daochu_f_purpose} is null then 1=1 else cust.purpose = ${fld:daochu_f_purpose} end)
--个人爱好
and (case when ${fld:daochu_f_personalhobbit} is null then 1=1 else cust.personalhobbit = ${fld:daochu_f_personalhobbit} end)
--婚姻情况
and (case when ${fld:daochu_f_marriage} is null then 1=1 else cust.marriage = ${fld:daochu_f_marriage} end)
--子女情况
and (case when ${fld:daochu_f_children} is null then 1=1 else cust.children = ${fld:daochu_f_children} end)

--0会员1资源
and (case when ${fld:daochu_f_custtype} is null then 1=1 
		when ${fld:daochu_f_custtype}='0' then 1=2
		when ${fld:daochu_f_custtype}='1' then 1=1 
	end) 
--录入日期
and (case when ${fld:daochu_startdate} is null then 1=1 else cust.created >= ${fld:daochu_startdate} end)
--录入日期
and (case when ${fld:daochu_enddate} is null then 1=1 else cust.created <= ${fld:daochu_enddate} end)

	

/*-----------------------------------------------------------------*/