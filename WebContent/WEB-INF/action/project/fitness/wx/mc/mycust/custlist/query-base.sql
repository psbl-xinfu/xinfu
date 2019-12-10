 select
 	g.officename
 	,g.code as guestcode
 	,the.code as thecode
	,the.name as vc_name
	,(case the.sex when
    	'0' then '女'
    	 when '1' then '男'
    	 when '2' then '未知'
    end) as i_sex
	,the.mobile as vc_mobile
	,(select posname from cc_position where code=the.positioncode ) as cc_position
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
where 
	g.mc = '${def:user}' and g.org_id=${def:org} 
	and cm.nexttime::date >= ${fld:startdate}
	AND cm.nexttime::date <= ${fld:enddate}
	${filter}
 order by created desc 