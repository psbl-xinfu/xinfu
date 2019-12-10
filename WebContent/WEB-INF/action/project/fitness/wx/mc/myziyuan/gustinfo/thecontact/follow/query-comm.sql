 select
 	cm.code,
	(case cm.commresult when 
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
	,cm.nexttime --下次跟进时间
from cc_comm cm
where cm.createdby='${def:user}' and cm.guestcode=${fld:guestcode} and cm.thecontactcode=${fld:thecode}
 order by created desc 