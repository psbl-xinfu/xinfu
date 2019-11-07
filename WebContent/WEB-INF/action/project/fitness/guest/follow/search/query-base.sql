 select
 	
 concat('<label class="am-checkbox"><input type="checkbox"  data-am-ucheck name="datalist" 
	
 value="',the.code::varchar,'','" > </label>') as application_id,
	g.officename
	,the.name as vc_name
	,(case the.sex when
    	'0' then '女'
    	 when '1' then '男'
    	 when '2' then '未知'
    end) as i_sex
	,the.mobile as vc_mobile
	,(case when the.position =1 then '投资人'
	when the.position =2 then '总监'
	when the.position =3 then '会籍经理'
	when the.position =4 then '私教经理'
	when the.position =5 then '会籍'
	when the.position =6 then '私教'
	end) as cc_position
	,(case cm.commresult when 
		'1' then '未建立关系'
		when '2' then '建立关系'
		when '3' then '了解需求'
		when '4' then '对接产品价值'
		when '5' then '要承诺'
		when '6' then '暂时搁置'
		when '7' then '成交'
		when '8' then '未成交'
	end) as gj_commresult
	,cm.remark
	,cm.created
	,(select name from hr_staff where userlogin=g.mc ) as vc_mc
from cc_comm cm
left join cc_guest g on cm.guestcode = g.code and cm.org_id = g.org_id
left join cc_thecontact the on the.code=cm.thecontactcode and the.org_id=cm.org_id
where (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where (hs.org_id = ${def:org} or exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else g.mc = '${def:user}' end)
${filter} 
 order by created desc 