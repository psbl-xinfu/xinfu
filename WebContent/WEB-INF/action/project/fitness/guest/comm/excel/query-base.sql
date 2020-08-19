select
	g.officename
	,the.name as vc_name
	,(case the.sex when
    	'0' then '女'
    	 when '1' then '男'
    	 when '2' then '未知'
    end) as i_sex
	,the.mobile as vc_mobile
	,(select posname from cc_position where code=the.positioncode ) as cc_position
	,(case c.commresult when 
		'1' then '未建立关系'
		when '2' then '建立关系'
		when '3' then '了解需求'
		when '4' then '对接产品价值'
		when '5' then '要承诺'
		when '6' then '暂时搁置'
		when '7' then '成交'
		when '8' then '未成交'
	end) as gj_commresult
	,cc.mmremark
	,to_char(c.created,'yyyy-MM-dd hh:MM:ss') as created
	,(select name from hr_staff where userlogin=c.createdby ) as vc_mc

 from cc_comm c
RIGHT JOIN (SELECT 
max(code) as mmcode,
thecontactcode,
string_agg(remark::VARCHAR, to_char(created,'yyyy-MM-dd hh:MM')) as mmremark
from cc_comm 
GROUP BY thecontactcode) cc on cc.mmcode=c.code 

left join cc_guest g on c.guestcode = g.code 
left join cc_thecontact the on the.code=c.thecontactcode 
where (case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where ( exists(select 1 from hr_staff_org so where  userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else g.mc = '${def:user}' end)
${filter} 

 order by officename,vc_mobile desc 