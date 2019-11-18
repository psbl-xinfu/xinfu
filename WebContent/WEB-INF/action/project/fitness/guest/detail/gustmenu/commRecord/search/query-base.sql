select
	the.name as vc_name
	,(case the.sex when
    	'0' then '女'
    	 when '1' then '男'
    	 when '2' then '未知'
    end) as i_sex
	,the.mobile as vc_mobile
	,(case when the.position =1 then '投资人'
	when the.position =2 then '总经理'
	when the.position =3 then '会籍总监'
	when the.position =4 then '会籍经理'
	when the.position =5 then '私教总监'
	when the.position =6 then '私教经理'
	when the.position =7 then '会籍'
	when the.position =8 then '私教'
	when the.position =9 then '店长'
	when the.position =10 then '人事'
	when the.position =11 then '会籍主管'
	when the.position =12 then '私教主管'
	when the.position =13 then '运营经理'
	when the.position =14 then '市场部经理'
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
from  cc_comm cm  
left join cc_thecontact the on cm.thecontactcode=the.code and the.org_id='${def:org}'
where cm.guestcode=${fld:id}
 and cm.org_id='${def:org}' 
 ${filter}
 
 order by created desc

