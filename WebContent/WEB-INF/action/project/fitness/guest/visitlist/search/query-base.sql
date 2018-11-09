select
	concat('<input type="radio" class="preparelist" name="preparelist" code="', COALESCE(tp.vc_preparecode,''), '" code1="', COALESCE(tp.vc_name,'')
  	, '" code2="', COALESCE(tp.prepare_status,100), '" code5="', COALESCE(tp.visit_status,10), '" code3="', COALESCE(tp.vc_contractcode,'')
  	, '" codenum="', tp.num,'" code4="', COALESCE(tp.vi_vc_code,''), '" code-status="', COALESCE(tp.i_status,100), '" code_date="', COALESCE(tp.vc_preparedate::varchar,''),
  	'" value="', COALESCE(tp.vc_code,''), '">') as application_id,
	* ,
	(SELECT config.param_value as day FROM cc_config config WHERE 
	config.category = 'GuestOutdate' and 
	config.org_id = (case when 
	not exists(select 1 from cc_config c where c.org_id = ${def:org} and c.category=config.category) 
	then (select org_id from hr_org where pid is null or pid = 0 and org_id = ${def:org}) else ${def:org} end))
	as num_days,
	(select (case when commresult=0 then '免打扰'
			when commresult=1 then '下次通话提醒'
			when commresult=2 then '预约到店'
			when commresult=3 then '成交'
		end) as commresult from cc_comm where customercode = cust_code and cc_comm.org_id = ${def:org})
from (
	-- 正常预约、到店、签署合同
	select 	
		r.code as cust_code,
		g.code as vc_code,-- 资源编号
		g.name as vc_name,-- 姓名
		(case g.sex when 0 then '女' when 1 then '男' else '' end) as i_sex,-- 性别
		g.age as i_age,--年龄
		p.code as vc_preparecode,-- 预约编号
		g.mobile as vc_contactway,--联系方式
		p.preparetime as vc_preparetime,-- 预约时间
		p.preparedate as vc_preparedate,-- 预约日期
		p.createdby as vc_mc,
		(select name from hr_staff where userlogin = p.createdby) as preparemc,
		g.status as i_status,-- 资源状态
		p.status as prepare_status,-- 预约状态
		(case when v.status > 0 or (select count(1) from cc_guest_visit where guestcode = g.code and org_id = ${def:org})>0 then '已来访' else 
		(case when p.status=0 then '无效'
			when p.status=1 then '正常'
			when p.status=2 then '已确认'
			when p.status=3 then '爽约'
			when p.status=4 then '已来访'
			when p.status=5 then '已取消'
		end) end) as prepare_type,-- 预约状态
		v.status as visit_status,-- 来访状态
		v.code as vi_vc_code,-- 来访编号
		v.visitdate as vc_visitdate,-- 来访日期
		v.visittime as vc_visittime,-- 来访时间
		(select name from hr_staff where userlogin = v.createdby) as vc_iuser,-- 前台
		(select name from hr_staff where userlogin = v.mc) as vc_visitmc,-- 接待会籍
		case when c.contracttype = 1 then c.factmoney end as dingjin,-- 定金
		case when c.contracttype != 1 then c.factmoney end as jine,-- 金额
		get_arr_value(c.relatecode, 9) as vc_cardtype,-- 卡种
		(select name from hr_staff where userlogin = r.mc) as contractmc,-- 合同会籍
		c.code as vc_contractcode,-- 合同编号
		c.createdate as c_idate,-- 合同日期
		g.created as vc_itime,
		(select count(1) from cc_guest_visit where guestcode = g.code and org_id = ${def:org}) as num
	from cc_guest g 
	inner join cc_guest_prepare p on g.code = p.guestcode and p.status != 0 and g.org_id = p.org_id
	left join cc_guest_visit v on p.code = v.preparecode and v.status != 0 and v.org_id = p.org_id
	left join cc_contract c on c.code = v.contractcode and c.status != 0 and c.org_id = v.org_id
	left join cc_customer r on r.code = c.guestcode and r.org_id = c.org_id 
	where 
		(case when ${fld:cust_all} is null then (p.preparedate >= ${fld:start_date} and p.preparedate <= ${fld:end_date}) else 1=1 end)
		and g.org_id = ${def:org}
		and (case when ${fld:status} is null then 1=1 
			when ${fld:status}='6'
			then exists(
				select 1 from cc_guest_prepare
				where status=1 and org_id = ${def:org}
				and '${def:timestamp}'::timestamp > concat(preparedate,' ', preparetime)::timestamp
				and cc_guest_prepare.code = p.code
			)
			else p.status = ${fld:status} end)
		and (case when ${fld:cust_all} is null then 1=1 else (g.code like concat('%', ${fld:cust_all}, '%') or g.name like concat('%', ${fld:cust_all}, '%') or g.mobile like concat('%', ${fld:cust_all}, '%')) end)
		and (case when ${fld:mc} is null then 1=1 else p.createdby = ${fld:mc} end)
		and (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
					where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
					and hss.userlogin = '${def:user}' and hs.data_limit = 1)
					then 1=1 else p.createdby = '${def:user}' end)
		
	union 
	-- 无预约到店 
	select 
		r.code as cust_code,
		g.code as vc_code,-- 资源编号
		g.name as vc_name,-- 姓名
		(case g.sex when 0 then '女' when 1 then '男' else '' end) as i_sex,-- 性别
		g.age as i_age,--年龄
		null as vc_preparecode,-- 预约编号
		g.mobile as vc_contactway,--联系方式
		null as vc_preparetime,-- 预约时间
		null as vc_preparedate,-- 预约日期
		null as vc_mc,
		null as preparemc,
		g.status as i_status,-- 资源状态
		null as prepare_status,-- 预约状态
		 '已来访' as prepare_type,-- 预约状态
		v.status as visit_status,-- 来访状态
		v.code as vi_vc_code,-- 来访编号
		v.visitdate as vc_visitdate,-- 来访日期
		v.visittime as vc_visittime,-- 来访时间
		(select name from hr_staff where userlogin = v.createdby) as vc_iuser,-- 前台
		(select name from hr_staff where userlogin = v.mc) as vc_visitmc,-- 接待会籍
		case when c.contracttype = 1 then c.factmoney end as dingjin,-- 定金
		case when c.contracttype != 1 then c.factmoney end as jine,-- 金额
		get_arr_value(c.relatecode, 9) as vc_cardtype,-- 卡种
		(select name from hr_staff where userlogin = r.mc) as contractmc,-- 合同会籍
		c.code as vc_contractcode,-- 合同编号
		c.createdate as c_idate,-- 合同日期
		g.created as vc_itime,
		(select count(1) from cc_guest_visit where guestcode = g.code and org_id = ${def:org}) as num
	from cc_guest g 
	inner join cc_guest_visit v on g.code = v.guestcode and v.status != 0 and g.org_id = v.org_id
	left join cc_contract c on c.code = v.contractcode and c.status != 0 and c.org_id = v.org_id
	left join cc_customer r on r.code = c.guestcode and r.org_id = c.org_id 
	where (v.preparecode is null or v.preparecode = '') and g.org_id = ${def:org}
		and (case when ${fld:cust_all} is null then (v.visitdate >= ${fld:start_date} and v.visitdate <= ${fld:end_date}) else 1=1 end)
		and (case when ${fld:mc} is null then 1=1 else v.mc = ${fld:mc} end) 
		and (case when ${fld:status} is null then true when ${fld:status} = '4' then true else false end)
		and (case when ${fld:cust_all} is null then 1=1 else (g.code like concat('%', ${fld:cust_all}, '%') or g.name like concat('%', ${fld:cust_all}, '%') or g.mobile like concat('%', ${fld:cust_all}, '%')) end)
		and (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
					where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
					and hss.userlogin = '${def:user}' and hs.data_limit = 1)
					then 1=1 else g.mc = '${def:user}' end)
	union 
	-- 直接签署合同
	select 
		m.code as cust_code,
		g.code as vc_code,-- 资源编号
		g.name as vc_name,-- 姓名
		(case g.sex when 0 then '女' when 1 then '男' else '' end) as i_sex,-- 性别
		g.age as i_age,--年龄
		null as vc_preparecode,-- 预约编号
		null as vc_contactway,--联系方式
		null as vc_preparetime,-- 预约时间
		null as vc_preparedate,-- 预约日期
		null as vc_mc,
		null as preparemc,
		g.status as i_status,-- 资源状态
		null as prepare_status,-- 预约状态
		'已来访' as prepare_type,-- 预约状态
		null as visit_status,-- 来访状态
		null as vi_vc_code,-- 来访编号
		null as vc_visitdate,-- 来访日期
		null as vc_visittime,-- 来访时间
		null as vc_iuser,-- 前台
		null as vc_visitmc,-- 接待会籍
		case when c.contracttype = 1 then c.factmoney end as dingjin,-- 定金
		case when c.contracttype != 1 then c.factmoney end as jine,-- 金额
		get_arr_value(c.relatecode, 9) as vc_cardtype,-- 卡种
		(select name from hr_staff where userlogin = m.mc) as contractmc,-- 合同会籍
		c.code as contractcode,-- 合同编号
		c.createdate as c_idate,-- 合同日期
		g.created as vc_itime,
		(select count(1) from cc_guest_visit where guestcode = g.code and org_id = ${def:org}) as num
	from cc_contract c 
	inner join cc_customer m on m.code=c.guestcode and c.org_id = m.org_id
	inner join cc_guest g on g.code=m.guestcode and g.org_id = m.org_id
	and (case when ${fld:cust_all} is null then 1=1 else (g.code like concat('%', ${fld:cust_all}, '%') or g.name like concat('%', ${fld:cust_all}, '%') or g.mobile like concat('%', ${fld:cust_all}, '%')) end)
	where (case when ${fld:cust_all} is null then (c.createdate >= ${fld:start_date} and c.createdate <= ${fld:end_date}) else 1=1 end)
	and c.contracttype = 0 and c.type in (0,5) and c.org_id = ${def:org} 
	and m.status != 0 and c.org_id = ${def:org} and not exists(
		select 1 from cc_guest_visit v where c.code = v.contractcode
	)
	and exists(select 1 from cc_guest_prepare p where p.guestcode = g.code 
	and (case when ${fld:mc} is null then 1=1 else p.createdby = ${fld:mc} end)
	and (case when ${fld:status} is null then 1=1 
			when ${fld:status}='6'
			then exists(
				select 1 from cc_guest_prepare
				where status=1 and org_id = ${def:org}
				and '${def:timestamp}'::timestamp > concat(preparedate,' ', preparetime)::timestamp
				and cc_guest_prepare.code = p.code
			)
	else p.status = ${fld:status} end))
	and (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else c.salemember = '${def:user}' or c.salemember1 = '${def:user}' end)
) tp
