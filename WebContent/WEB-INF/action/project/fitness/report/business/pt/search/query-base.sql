select 
	(select name from hr_staff where userlogin = t.userlogin and org_id = ${def:org}) as staff_name,
	t.userlogin,
	sum(freenum) as freenum,--已上体验课
	sum(feenum) as feenum,--已上收费课
	sum(giverestnum) as giverestnum,--已上赠课
	sum(totalfee) as totalfee,--总金额
	sum(totalnum) as totalnum, --总课时
	sum(shengyutiyan)::int as shengyutiyan,--剩余体验课
	sum(shengyushoufei)::int as shengyushoufei,--剩余收费课
	sum(shengyuzengke)::int as shengyuzengke,--剩余赠课
	sum(xingouke) as xingouke,--新购课课时
	sum(xingoukejine) as xingoukejine,--新购课金额
	(case when sum(xingouke)=0 then 0 else (sum(xingoukejine)/sum(xingouke))::NUMERIC(10, 2) end) as xingoukejunjia,--新购课均价
	sum(xufeike) as xufeike,--续费课课时
	sum(xufeikejine) as xufeikejine,--续费课金额
	(case when sum(xufeike)=0 then 0 else (sum(xufeikejine)/sum(xufeike))::NUMERIC(10, 2) end) as xufeikejunjia,--续费课均价
	concat((case when sum(totalnum)=0 then 0 else ((sum(freenum)+sum(feenum))/sum(totalnum)*100)::NUMERIC(10, 2) end), '%') as haokelv,--耗课率
	(case when sum(totalnum)=0 then 0 else (sum(totalfee)/sum(totalnum))::NUMERIC(10, 2) end) as keshijunjia,--课时均价
	sum(zkptleftcount)::int as zkptleftcount,--赠课课时
	sum(zkptmoney) as zkptmoney,--赠课金额
	(case when sum(zkptleftcount)=0 then 0 else (sum(zkptmoney)/sum(zkptleftcount))::NUMERIC(10, 2) end) as zkjunjia
from
(select 
	case when t1.ptid is not null and t1.ptid != '' then t1.ptid 
		when t2.salemember is not null and t2.salemember != '' then t2.salemember 
		when t3.ptid is not null and t3.ptid != '' then t3.ptid 
		when t4.ptid is not null and t4.ptid != '' then t4.ptid 
		when t5.ptid is not null and t5.ptid != '' then t5.ptid 
		when t6.ptid is not null and t6.ptid != '' then t6.ptid 
	end as userlogin,
	COALESCE(t1.freenum,0) as freenum,--体验课
	COALESCE(t1.feenum,0) as feenum,--收费课
	COALESCE(t1.giverestnum,0) as giverestnum,--赠课
	COALESCE(t2.totalfee,0) as totalfee,--总金额
	COALESCE(t2.totalnum,0) as totalnum,--总课时
	COALESCE(t3.shengyutiyan,0) as shengyutiyan,
	COALESCE(t3.shengyushoufei,0) as shengyushoufei,
	COALESCE(t3.shengyuzengke,0) as shengyuzengke,
	COALESCE(t4.xingouke,0) as xingouke,
	COALESCE(t4.xingoukejine,0) as xingoukejine,
	COALESCE(t5.xufeike,0) as xufeike,
	COALESCE(t5.xufeikejine,0) as xufeikejine,
	COALESCE(t6.zkptleftcount,0) as zkptleftcount,
	COALESCE(t6.zkptmoney,0) as zkptmoney
from (
	select 
		sum(case when d.reatetype = 1 and pr.pttype!=5 then 1 else 0 end) as freenum,--体验课
		sum(case when d.reatetype = 0 and pr.pttype!=5 then 1 else 0 end) as feenum,--收费课
		sum(case when pr.pttype=5 then 1 else 0 end) as giverestnum,--赠课
		p.ptid
	from cc_ptlog p 
	left join cc_ptdef d on d.code = p.ptlevelcode and p.org_id = d.org_id
	left join cc_ptrest pr on pr.code = p.ptrestcode and pr.org_id = p.org_id
	where p.status != 0 and p.org_id = ${def:org}  
	and (case when ${fld:start_date} is null then 1=1 else p.created::date>=${fld:start_date} end)
	and (case when ${fld:end_date} is null then 1=1 else p.created::date<=${fld:end_date} end)
 	and (case when ${fld:skill_name} is null then 1=1 else p.ptid=${fld:skill_name} end)
	and exists(
	 		select 1 from hr_skill k 
	 		inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
	 		where k.skill_scope = '1'  and fk.userlogin = p.ptid and k.org_id = p.org_id
	 		and (case when ${fld:skill_name} is null then 1=1 else fk.userlogin=${fld:skill_name} end)
	 	)
	group by p.ptid 
) as t1 
full join (
	select c.salemember, sum(case when c.salemember1 is not null and c.salemember1 != '' then c.normalmoney/2.00 else c.normalmoney end) as totalfee, sum(COALESCE(get_arr_value(c.relatedetail,2)::int,0)) as totalnum 
	from cc_contract c 
	where c.contracttype = 0 and c.type = 2 and c.status >= 2 and c.org_id = ${def:org}  
	and (case when ${fld:start_date} is null then 1=1 else c.createdate>=${fld:start_date} end)
	and (case when ${fld:end_date} is null then 1=1 else c.createdate<=${fld:end_date} end)
 	and (case when ${fld:skill_name} is null then 1=1 else c.salemember=${fld:skill_name} end)
	and exists(
 			select 1 from hr_skill k 
 			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 			where k.skill_scope = '1'  and fk.userlogin = c.salemember and k.org_id = c.org_id
 			and (case when ${fld:skill_name} is null then 1=1 else fk.userlogin=${fld:skill_name} end)
 		)
	group by c.salemember
	union all 
	select c.salemember1, sum(c.normalmoney/2) as totalfee, sum(COALESCE(get_arr_value(c.relatedetail,2)::int,0)) as totalnum 
	from cc_contract c 
	where c.contracttype = 0 and c.type = 2 and c.status >= 2 and c.org_id = ${def:org} 
	and c.salemember1 is not null and c.salemember1 != '' 
	and (case when ${fld:start_date} is null then 1=1 else c.createdate>=${fld:start_date} end)
	and (case when ${fld:end_date} is null then 1=1 else c.createdate<=${fld:end_date} end)
 	and (case when ${fld:skill_name} is null then 1=1 else c.salemember1=${fld:skill_name} end)
	and exists(
 			select 1 from hr_skill k 
 			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 			where k.skill_scope = '1'  and fk.userlogin = c.salemember1 and k.org_id = c.org_id
 			and (case when ${fld:skill_name} is null then 1=1 else fk.userlogin=${fld:skill_name} end)
 		)
	group by c.salemember1
) as t2 on t1.ptid = t2.salemember 
full join (
	select 
	sum(case when pd.reatetype=1 and pr.pttype!=5 then ptleftcount else 0 end) as shengyutiyan,
	sum(case when pd.reatetype=0 and pr.pttype!=5 then ptleftcount else 0 end) as shengyushoufei,
	sum(case when pr.pttype=5 then ptleftcount else 0 end) as shengyuzengke,
	pr.ptid 
	from cc_ptrest pr 
	left join cc_ptdef pd on pr.ptlevelcode = pd.code and pr.org_id = pd.org_id
	where pr.org_id = ${def:org}
	and (case when ${fld:start_date} is null then 1=1 else pr.created::date>=${fld:start_date} end)
	and (case when ${fld:end_date} is null then 1=1 else pr.created::date<=${fld:end_date} end)
 	and (case when ${fld:skill_name} is null then 1=1 else pr.ptid=${fld:skill_name} end)
	and exists(
 			select 1 from hr_skill k 
 			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 			where k.skill_scope = '1'  and fk.userlogin = pr.ptid and k.org_id = pr.org_id
 			and (case when ${fld:skill_name} is null then 1=1 else fk.userlogin=${fld:skill_name} end)
 		) GROUP BY pr.ptid
)as t3 on t1.ptid = t3.ptid
full join(
	select
		sum(COALESCE(get_arr_value(c.relatedetail,2)::int,0.00)) as xingouke,
		sum(c.factmoney) as xingoukejine,
		get_arr_value(c.relatedetail,8) as ptid
	from cc_contract c 
	where 1=1 
	and c.org_id=${def:org} and c.status>=2 and c.type = 2 and contracttype = 0
	and (case when ${fld:start_date} is null then 1=1 else c.createdate>=${fld:start_date} end)
	and (case when ${fld:end_date} is null then 1=1 else c.createdate<=${fld:end_date} end)
 	and (case when ${fld:skill_name} is null then 1=1 else get_arr_value(c.relatedetail,8)=${fld:skill_name} end)
 	and exists(
			select 1 from hr_skill k 
			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
			where k.skill_scope = '1'  and fk.userlogin = get_arr_value(c.relatedetail,8) and k.org_id = c.org_id
 			and (case when ${fld:skill_name} is null then 1=1 else fk.userlogin=${fld:skill_name} end)
		)
	and (case when (select count(1) from cc_ptrest where customercode = c.customercode and org_id = c.org_id)>1 
			then exists(select 1 from dual where c.code = 
	(select contractcode from cc_ptrest where customercode = c.customercode and org_id = c.org_id order by created asc limit 1)) else 1=1  end)
	group by ptid
)as t4 on t1.ptid = t4.ptid
full join(
	select
		sum(COALESCE(get_arr_value(c.relatedetail,2)::int,0.00)) as xufeike,
		sum(c.factmoney) as xufeikejine,
		get_arr_value(c.relatedetail,8) as ptid
	from cc_contract c 
	where c.org_id=${def:org} and c.status>=2 and c.type = 2 and contracttype = 0
	and (case when ${fld:start_date} is null then 1=1 else c.createdate>=${fld:start_date} end)
	and (case when ${fld:end_date} is null then 1=1 else c.createdate<=${fld:end_date} end)
 	and (case when ${fld:skill_name} is null then 1=1 else get_arr_value(c.relatedetail,8)=${fld:skill_name} end)
 	and exists(
			select 1 from hr_skill k 
			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
			where k.skill_scope = '1'  and fk.userlogin = get_arr_value(c.relatedetail,8) and k.org_id = c.org_id
 			and (case when ${fld:skill_name} is null then 1=1 else fk.userlogin=${fld:skill_name} end)
		)
	and exists(select 1 from dual where c.code != 
	(select contractcode from cc_ptrest where customercode = c.customercode and org_id = c.org_id order by created asc limit 1))
	group by ptid
)as t5 on t1.ptid = t5.ptid
full join(
	select 
		sum(pr.pttotalcount) as zkptleftcount,
		sum(pr.ptmoney) as zkptmoney,
		pr.ptid 
	from cc_ptrest pr 
	where pr.org_id = ${def:org} and pr.pttype=5 
	and (case when ${fld:start_date} is null then 1=1 else pr.created::date>=${fld:start_date} end)
	and (case when ${fld:end_date} is null then 1=1 else pr.created::date<=${fld:end_date} end)
 	and (case when ${fld:skill_name} is null then 1=1 else pr.ptid=${fld:skill_name} end)
	and exists(
 			select 1 from hr_skill k 
 			inner join hr_staff_skill fk on k.skill_id = fk.skill_id 
 			where k.skill_scope = '1'  and fk.userlogin = pr.ptid and k.org_id = pr.org_id
 			and (case when ${fld:skill_name} is null then 1=1 else fk.userlogin=${fld:skill_name} end)
 		) GROUP BY pr.ptid
)as t6 on t1.ptid = t6.ptid
) t GROUP BY userlogin