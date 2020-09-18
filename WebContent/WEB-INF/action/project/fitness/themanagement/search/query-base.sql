select
	the.code as thecode
	,the.name as thename
	,the.mobile as  themobile
	,g.code as gcode
	,g.officename as  gofficename
	,b.storename
	,p.posname
	,c.remark
	,to_char(c.created,'yyyy-MM-dd hh:MM:ss') as created
from 
cc_thecontact the 
left join cc_guest g on the.guestcode = g.code
left join cc_branch b on the.branchcode = b.code
left join cc_position p on the.positioncode= p.code
left join 
(select thecontactcode,remark,created from cc_comm 
right join ( select max (code)as code from cc_comm group by thecontactcode)  cc on cc.code =cc_comm.code) c on c.thecontactcode=the.code
WHERE 
(case when exists(select 1 from hr_staff_skill hss inner join hr_skill hs on hss.skill_id = hs.skill_id 
			where ( exists(select 1 from hr_staff_org so where hs.org_id = so.org_id and userlogin = '${def:user}'))
			and hss.userlogin = '${def:user}' and hs.data_limit = 1)
			then 1=1 else g.mc = '${def:user}' end)
and  
(case when 
	${fld:city} is not null then g.province2 = ${fld:province} and g.city2=${fld:city}
	when  ${fld:city} is null then (case when 
		${fld:province} is not null then g.province2 = ${fld:province}
		else 1=1
	end)
	else 1=1
end)
${filter} 
