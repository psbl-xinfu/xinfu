select 
	gt.code as ofcode,
	the.code as thecode,
	the.name as thename,--联系人名称
	gt.officename,
	(case cm.commresult when 
		'1' then '未建立关系'
		when '2' then '建立关系'
		when '3' then '了解需求'
		when '4' then '对接产品价值'
		when '5' then '要承诺'
		when '6' then '暂时搁置'
		when '7' then '成交'
		when '8' then '未成交'
	end) as commresult,
	cm.remark,
	cm.created
	
from cc_thecontact the
left join cc_guest gt on the.guestcode=gt.code
left join (select commresult,thecontactcode,guestcode,remark,created 
from cc_comm where thecontactcode=${fld:thecode} 
and org_id=${def:org} order by created desc limit 1) cm on cm.thecontactcode=the.code
where the.org_id = ${def:org} and the.code=${fld:thecode}
