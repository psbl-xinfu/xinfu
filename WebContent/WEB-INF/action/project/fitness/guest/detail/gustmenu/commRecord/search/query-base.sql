select
	the.name as vc_name
	,(case the.sex when
    	'0' then '女'
    	 when '1' then '男'
    	 when '2' then '未知'
    end) as i_sex
	,the.mobile as vc_mobile
	,(select posname from cc_position  where the.positioncode=code) as cc_position
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
from  cc_comm cm  
INNER join cc_thecontact the on cm.thecontactcode=the.code and the.org_id='${def:org}'
where cm.guestcode=${fld:id}
 and cm.org_id='${def:org}' 
 ${filter}
 
 order by created desc

