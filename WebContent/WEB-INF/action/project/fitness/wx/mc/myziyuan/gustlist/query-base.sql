with protectdey as (SELECT 
	config.param_value as dayval
FROM 
	cc_config config 
WHERE 
	config.category = 'GuestOutdate'
and 
	config.org_id = (case when 
	not exists(select 1 from cc_config c where c.org_id = ${def:org} and c.category=config.category) 
	then (select org_id from hr_org where pid is null or pid = 0) else ${def:org} end)
)
(select
	g.mobile,
	g.code as vc_code,
	tt.name as vc_name,
	g.officename ,
    (case tt.sex when
    	'0' then '女'
    	 when '1' then '男'
    	 when '2' then '未知'
    end) as i_sex,
	tt.mobile as vc_mobile,
	
	(select posname from cc_position where code=tt.positioncode) as cc_position,
	g.othertel as vc_othertel,
	g.created::date as vc_itime,--录入日期
	(select name from hr_staff where userlogin=g.mc 
	) as vc_newmc,
	(select (case v.commresult when 
		'1' then '未建立关系'
		when '2' then '建立关系'
		when '3' then '了解需求'
		when '4' then '对接产品价值'
		when '5' then '要承诺'
		when '6' then '暂时搁置'
		when '7' then '成交'
		when '8' then '未成交'
	end) from cc_comm v where v.guestcode = g.code and v.org_id = g.org_id order by v.created desc limit 1) as vc_commresult,--最新跟进状态
	(select m.remark from cc_comm m where m.guestcode = g.code and m.org_id = g.org_id order by m.created desc limit 1) as gj_remark,
	
	p.entertime,--最新分配日期
	(case when
	(p.grabtime::date+((select dayval from protectdey)||'day')::interval)::date - now()::date >= 0 then '否'
	when (p.grabtime::date+((select dayval from protectdey)||'day')::interval)::date - now()::date < 0 then '是'
	end) as i_public,--是否进入公海
	(case when (p.grabtime::date+((select dayval from protectdey)||'day')::interval)::date - now()::date < 0
	then concat('已过期', now()::date-(p.grabtime::date+((select dayval from protectdey)||'day')::interval)::date,'天')
	when (p.grabtime::date+((select dayval from protectdey)||'day')::interval)::date - now()::date >= 0
	then concat('未过期', (p.grabtime::date+((select dayval from protectdey)||'day')::interval)::date - now()::date ,'天')
	end) as num_days, --保护期天数
	g.communication, --沟通阶段
	lablg.lablgname,
	lablg.lablgcode,
	tt.mobile
from cc_guest g 
left join cc_public p on p.guestcode=g.code  and p.org_id=g.org_id
left join (select guestcode,name,mobile,positioncode,sex from cc_thecontact where 
 status=1  and org_id=${def:org} ) as tt on tt.guestcode=g.code 
left join (select lg.guestcode,string_agg(la.name,';') as lablgname,
string_agg(lg.labelcode,';'order by lg.labelcode asc) as lablgcode
from cc_label_guest lg
left join cc_label la on lg.labelcode=la.code where lg.org_id=${def:org} group by lg.guestcode ) as lablg on lablg.guestcode=g.code
WHERE 
g.mc='${def:user}'
and (case when 
	${fld:s_city} is not null then g.province2 = ${fld:s_province} and g.city2=${fld:s_city}
	when  ${fld:s_city} is null then (case when 
		${fld:s_province} is not null then g.province2 = ${fld:s_province}
		else 1=1
	end)
	else 1=1
end)
and
 	g.org_id = ${def:org}
 	${filter}
  )
 
order by vc_code desc